#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#include "los_task.h"
#include "ohos_init.h"
#include "cmsis_os.h"
#include "config_network.h"
#include "smart_home.h"
#include "smart_home_event.h"
#include "su_03t.h"
#include "iot.h"
#include "lcd.h"
#include "picture.h"
#include "adc_key.h"
#include "nfc.h"
#include "eeprom.h"
#include "mq2.h"
#include "iot_pwm.h"

#define ROUTE_SSID      "DESKTOP-51VKJH4 9627"          // WiFi账号
#define ROUTE_PASSWORD "88888888"       // WiFi密码

#define MSG_QUEUE_LENGTH                                16
#define BUFFER_LEN                                      50

//蜂鸣器
#define BEEP_PORT EPWMDEV_PWM5_M0


/***************************************************************
 * 函数名称: nfc_process
 * 说    明: nfc线程
 * 参    数: 无
 * 返 回 值: 无
 ***************************************************************/







// #define TEXT        "打开进入此系统！"
// #define WEB         "bilibili.com"

unsigned int key_num;

void nfc_process(void)
{
    unsigned int ret = 0;
    

    nfc_deinit();
    /* 初始化NFC设备 */
    ret = nfc_init();
    if (ret != 0) {
        printf("NFC初始化失败: %d\n", ret);
        return;
    }
    eeprom_init();
    eeprom_writebyte(0xFF,0);

    // /* 写入文本 */
    // ret = nfc_store_text(NDEFFirstPos, (uint8_t *)TEXT);
    // if (!ret) {
    //     printf("NFC写入文本失败: %d\n", ret);
    // }

    // /* 写入URL */
    // ret = nfc_store_uri_http(NDEFLastPos, (uint8_t *)WEB);
    // if (!ret) {
    //     printf("NFC写入URL失败: %d\n", ret);
    // }

    while (1) {
        if(get_nfc_state() == 1)
        {
            if (nfc_read_text(nfc_read_buf, sizeof(nfc_read_buf))) {
            printf("读取到NFC文本内容: %s\n", nfc_read_buf);
            } else {
                printf("未读取到NFC文本或读取失败\n");
            }
            // if(key_flag == 1)
            // {
            //     SavePassword(nfc_read_buf);
            //     
            //     key_flag = 0;
            // }
            for(uint8_t i=0;i<password_count;i++)
            {
                uint16_t addr = i * PASSWORD_LENGTH;
                eeprom_read(addr, eep_read_buf, PASSWORD_LENGTH);

                if(strcmp(nfc_read_buf,eep_read_buf) == 0)
                {
                    su03t_send_double_msg(4,1);
                    printf("识别成功打开门\n");
                    if(NT3HEraseAllTag())
                    {
                        memset(nfc_read_buf, 0, sizeof(nfc_read_buf));
                    }
                    break;
                }
            }
        }
        // eeprom_read(0x00,eep_read_buf,8);
        // printf("eep0x00存储的: %s\n",eep_read_buf);

        LOS_Msleep(1000);
    }
}

/***************************************************************
 * 函数名称: iot_thread
 * 说    明: iot线程
 * 参    数: 无
 * 返 回 值: 无
 ***************************************************************/
void iot_thread(void *args) {
  uint8_t mac_address[12] = {0x00, 0xdc, 0xb6, 0x90, 0x01, 0x00,0};

  char ssid[32]=ROUTE_SSID;
  char password[32]=ROUTE_PASSWORD;
  char mac_addr[32]={0};

  FlashDeinit();
  FlashInit();

  VendorSet(VENDOR_ID_WIFI_MODE, "STA", 3); // 配置为Wifi STA模式
  VendorSet(VENDOR_ID_MAC, mac_address, 6); // 多人同时做该实验，请修改各自不同的WiFi MAC地址
  VendorSet(VENDOR_ID_WIFI_ROUTE_SSID, ssid, sizeof(ssid));
  VendorSet(VENDOR_ID_WIFI_ROUTE_PASSWD, password,sizeof(password));

reconnect:
  printf("reconnect\n");
  SetWifiModeOff();
  int ret = SetWifiModeOn();
  if(ret != 0){
    printf("wifi connect failed,please check wifi config and the AP!\n");
    return;
  }
  mqtt_init();

  while (1) {
    // printf("iot_thread\n");
    if (!wait_message()) {
      goto reconnect;
    }
    LOS_Msleep(1);
  }
}


/***************************************************************
 * 函数名称: smart_home_thread
 * 说    明: 智慧家居主线程
 * 参    数: 无
 * 返 回 值: 无
 ***************************************************************/
void smart_home_thread(void *arg)
{
    double *data_ptr = NULL;

    double illumination_range = 50.0;
    double temperature_range = 35.0;
    double humidity_range = 80.0;

    e_iot_data iot_data = {0};

    i2c_dev_init();
    lcd_dev_init();
    motor_dev_init();
    light_dev_init();
    mq2_dev_init();
    LOS_Msleep(1000);
    mq2_ppm_calibration();
    IoTPwmInit(BEEP_PORT);
    su03t_init();
    // lcd_load_ui();
    lcd_show_ui();

    while(1)
    {
        // printf("home_thread\n");
        event_info_t event_info = {0};
        //等待事件触发,如有触发,则立即处理对应事件,如未等到,则执行默认的代码逻辑,更新屏幕
        int ret = smart_home_event_wait(&event_info,3000);
        if(ret == LOS_OK){
            //收到指令
            printf("event recv %d ,%d\n",event_info.event,event_info.data.iot_data);
            switch (event_info.event)
            {
                case event_key_press:
                    smart_home_key_process(event_info.data.key_no);
                    
                    break;
                case event_iot_cmd:
                    smart_home_iot_cmd_process(event_info.data.iot_data);
                    break;
                case event_su03t:
                    smart_home_su03t_cmd_process(event_info.data.su03t_data);
                    break;
               default:break;
            }

        }

        double temp,humi,lum,ppm;

        sht30_read_data(&temp,&humi);
        bh1750_read_data(&lum);
        get_mq2_ppm(&ppm);
        // if(ppm > 40 && ppm <90) {
        //     IoTPwmStart(BEEP_PORT,10,1000);
        // } else {
        //     IoTPwmStop(BEEP_PORT);
        // }

        lcd_set_illumination(lum);
        lcd_set_temperature(temp);
        lcd_set_humidity(humi);
        lcd_set_ppm(ppm);
        if (mqtt_is_connected()) 
        {
            
            // 发送iot数据
            iot_data.illumination = lum;
            iot_data.temperature = temp;
            iot_data.humidity = humi;
            iot_data.ppm = ppm;
            iot_data.light_state = get_light_state();
            iot_data.motor_state = get_motor_state();
            iot_data.nfc_state   = get_nfc_state();
            // iot_data.auto_state = auto_state;
            send_msg_to_mqtt(&iot_data);

            lcd_set_network_state(true);
        }else{  
            lcd_set_network_state(false);
        }

        lcd_show_ui();
    }
}

/***************************************************************
 * 函数名称: device_read_thraed
 * 说    明: 设备读取线程
 * 参    数: 无
 * 返 回 值: 无
 ***************************************************************/
// void device_read_thraed(void *arg)
// {
//     double read_data[3] = {0};

//     i2c_dev_init();

//     while(1)
//     {
//         bh1750_read_data(&read_data[0]);
//         sht30_read_data(&read_data[1]);
//         LOS_QueueWrite(m_msg_queue, (void *)&read_data, sizeof(read_data), LOS_WAIT_FOREVER);
//         LOS_QueueWrite(m_su03_msg_queue, (void *)&read_data, sizeof(read_data), LOS_WAIT_FOREVER);
//         LOS_Msleep(500);
//     }
// }

/***************************************************************
 * 函数名称: iot_smart_hone_example
 * 说    明: 开机自启动调用函数
 * 参    数: 无
 * 返 回 值: 无
 ***************************************************************/
void iot_smart_home_example()
{
    unsigned int thread_id_1;
    unsigned int thread_id_2;
    unsigned int thread_id_3;
    unsigned int thread_id_4;
    TSK_INIT_PARAM_S task_1 = {0};
    TSK_INIT_PARAM_S task_2 = {0};
    TSK_INIT_PARAM_S task_3 = {0};
    TSK_INIT_PARAM_S task_4 = {0};
    unsigned int ret = LOS_OK;
    
    smart_home_event_init();
    
    // ret = LOS_QueueCreate("su03_queue", MSG_QUEUE_LENGTH, &m_su03_msg_queue, 0, BUFFER_LEN);
    // if (ret != LOS_OK)
    // {
    //     printf("Falied to create Message Queue ret:0x%x\n", ret);
    //     return;
    // }

    task_1.pfnTaskEntry = (TSK_ENTRY_FUNC)smart_home_thread;
    task_1.uwStackSize = 2048;
    task_1.pcName = "smart hone thread";
    task_1.usTaskPrio = 24;
    
    ret = LOS_TaskCreate(&thread_id_1, &task_1);
    if (ret != LOS_OK)
    {
        printf("Falied to create task ret:0x%x\n", ret);
        return;
    }

    task_2.pfnTaskEntry = (TSK_ENTRY_FUNC)adc_key_thread;
    task_2.uwStackSize = 2048;
    task_2.pcName = "key thread";
    task_2.usTaskPrio = 24;
    ret = LOS_TaskCreate(&thread_id_2, &task_2);
    if (ret != LOS_OK)
    {
        printf("Falied to create task ret:0x%x\n", ret);
        return;
    }

    task_3.pfnTaskEntry = (TSK_ENTRY_FUNC)iot_thread;
    task_3.uwStackSize = 20480*5;
    task_3.pcName = "iot thread";
    task_3.usTaskPrio = 24;
    ret = LOS_TaskCreate(&thread_id_3, &task_3);
    if (ret != LOS_OK)
    {
        printf("Falied to create task ret:0x%x\n", ret);
        return;
    }

    task_4.pfnTaskEntry = (TSK_ENTRY_FUNC)nfc_process;
    task_4.uwStackSize = 10240;
    task_4.pcName = "nfc process";
    task_4.usTaskPrio = 24;
    ret = LOS_TaskCreate(&thread_id_4, &task_4);
    if (ret != LOS_OK)
    {
        printf("Falied to create task ret:0x%x\n", ret);
        return;
    }
}

APP_FEATURE_INIT(iot_smart_home_example);
