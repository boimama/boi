#ifndef _IOT_H_
#define _IOT_H_

#include <stdbool.h>

typedef struct
{
    double illumination;
    double temperature;
    double humidity;
    double ppm;
    bool motor_state;
    bool light_state;
    bool auto_state;
    bool nfc_state;
} e_iot_data;

#define IOT_CMD_LIGHT_ON 0x01
#define IOT_CMD_LIGHT_OFF 0x02
#define IOT_CMD_MOTOR_ON 0x03
#define IOT_CMD_MOTOR_OFF 0x04
#define IOT_CMD_AUTO_ON 0x05
#define IOT_CMD_AUTO_OFF 0x06
#define IOT_CMD_NFC_ON 0X07
#define IOT_CMD_NFC_OFF 0x08

int wait_message();
void mqtt_init();
unsigned int mqtt_is_connected();
void send_msg_to_mqtt(e_iot_data *iot_data);

#endif // _IOT_H_