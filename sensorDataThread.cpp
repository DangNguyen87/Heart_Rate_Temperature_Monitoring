#include <QDateTime>
#include <QtCore/QRandomGenerator>
#include "sensorDataThread.h"
#include "ecgData.h"

float SensorDataThread::readVoltageValue(enum ADS_CHANNEL channel)
{
    uint8_t writeBuf[3];	// Buffer to store the 3 bytes that we write to the I2C device
    uint8_t readBuf[2];		// 2 byte buffer to store the data read from the I2C device
    int16_t val;			// Stores the 16 bit value of our ADC conversion

    // These three bytes are written to the ADS1115 to set the config register and start a conversion
    // This sets the pointer register so that the following two bytes write to the config register
    writeBuf[0] = 1;

    switch (channel)
    {
        case ADS_CHANNEL_A0:
            // This sets the 8 MSBs of the config register (bits 15-8) to 11000011
            writeBuf[1] = 0xC3;
            break;
        case ADS_CHANNEL_A1:
            // This sets the 8 MSBs of the config register (bits 15-8) to 11010011
            writeBuf[1] = 0xD3;
            break;
        case ADS_CHANNEL_A2:
            // This sets the 8 MSBs of the config register (bits 15-8) to 11100011
            writeBuf[1] = 0xE3;
            break;
        case ADS_CHANNEL_A3:
            // This sets the 8 MSBs of the config register (bits 15-8) to 11110011
            writeBuf[1] = 0xF3;
            break;
        default:
            break;
    }
    // This sets the 8 LSBs of the config register (bits 7-0) to 00000011
    writeBuf[2] = 0x03;

    // Initialize the buffer used to read data from the ADS1115 to 0
    readBuf[0]= 0;
    readBuf[1]= 0;

    // Write writeBuf to the ADS1115, the 3 specifies the number of bytes we are writing, this begins a single conversion
    write(m_i2cFile, writeBuf, 3);

    // Wait for the conversion to complete, this requires bit 15 to change from 0->1
    while ((readBuf[0] & 0x80) == 0)	// readBuf[0] contains 8 MSBs of config register, AND with 10000000 to select bit 15
    {
        read(m_i2cFile, readBuf, 2);	// Read the config register into readBuf
    }

    // Set pointer register to 0 to read from the conversion register
    writeBuf[0] = 0;
    write(m_i2cFile, writeBuf, 1);

    // Read the contents of the conversion register into readBuf
    read(m_i2cFile, readBuf, 2);
    // Combine the two bytes of readBuf into a single 16 bit result
    val = readBuf[0] << 8 | readBuf[1];

    // Convert from binary value to mV
    return (float)val * 4.096 / 32767.0;
}

SensorDataThread::SensorDataThread(HeartRateDataModel* hrModel, TemperatureDataModel *tempModel)
{
    int i2cAddr = 0x48;	// Address of our device on the I2C bus

    m_hrModel = hrModel;
    m_tempModel = tempModel;
    m_startTime = QDateTime::currentMSecsSinceEpoch();

    // Open the I2C device
    m_i2cFile = open("/dev/i2c-1", O_RDWR);
    if (m_i2cFile == -1)
    {
        qDebug("Can not open device file of I2C device\n");
    }
    else
    {
        // Specify the address of the I2C Slave to communicate with
        ioctl(m_i2cFile, I2C_SLAVE, i2cAddr);
    }
}

SensorDataThread::~SensorDataThread()
{
    close(m_i2cFile);
}

void SensorDataThread::run()
{
    while (1)
    {
        qint64 startMeasure = QDateTime::currentMSecsSinceEpoch();

        /* Read ECG data */
        EcgData* ecg = new EcgData((startMeasure - m_startTime) / 1000,
                                   QRandomGenerator::global()->bounded(100));
        m_hrModel->addEcgData(ecg);
        qDebug("[Sensor thread] ECG data: %lld, %f\n", ecg->m_timeStamp, ecg->m_ecgValue);

        /* Read temperature data */
        if (m_i2cFile > 0)
        {
            // TSkin temperature connect to ADS channel 0, TRect temperature connect to ADS channel 1
            float vTskin = readVoltageValue(ADS_CHANNEL_A0);
            float vTrect = readVoltageValue(ADS_CHANNEL_A1);
            // Convert voltage value to temperature value
            TemperatureData* temp = new TemperatureData((startMeasure - m_startTime) / 1000,
                                                        TemperatureData::b3950CalcTemp(vTskin, 3.3, 10000),
                                                        TemperatureData::b3950CalcTemp(vTrect, 3.3, 10000));
            qDebug("[Sensor thread] Temperature data: %lld, %f, %f\n", temp->m_timeStamp, temp->m_tSkin, temp->m_tRect);
            m_tempModel->addTemperatureData(temp);
        }

        /* Calculate mearsure time, sleep if reading data time less than 1 second */
        qint64 measurePeriod = QDateTime::currentMSecsSinceEpoch() - startMeasure;
        if ((1000 - measurePeriod) > 0)
        {
            QThread::msleep(1000 - measurePeriod);
        }
    }
}
