/*
 * Copyright (c) 2024 iSoftStone Education Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdbool.h>
#include "stdint.h"
#include "rtdText.h"
#include "rtdUri.h"
#include "ndef.h"


/* 记录是否已经初始化 */
static unsigned char m_nfc_is_init = 0;

//////////////////////////////////////////////////////////////////////

void nfc_clear(void)
{
    uint8_t empty[] = "";
    nfc_store_text(NDEFFirstPos, empty);       // 清空文本
    nfc_store_uri_http(NDEFLastPos, empty);    // 清空 URI
    printf("NFC 标签内容已清空！\n");
}

bool nfc_read_text(uint8_t *out_text, uint16_t max_len)
{
    if (m_nfc_is_init == 0) {
        printf("%s, %s, %d: NFC is not init!\n", __FILE__, __func__, __LINE__);
        return false;
    }

    uint8_t endRecordLength = 0;
    uint8_t ndefHeader = 0;

    if (!NT3HReadHeaderNfc(&endRecordLength, &ndefHeader)) {
        printf("NDEF头读取失败\n");
        return false;
    }

    uint8_t totalPages = (endRecordLength + 1 + NFC_PAGE_SIZE - 1) / NFC_PAGE_SIZE;
    uint8_t buffer[128] = {0};
    uint8_t *p = buffer;

    for (uint8_t page = 0; page < totalPages && page < 119; page++) {
        if (!NT3HReadUserData(page)) {
            printf("读取用户区第%d页失败\n", page);
            return false;
        }
        memcpy(p, nfcPageBuffer, NFC_PAGE_SIZE);
        p += NFC_PAGE_SIZE;
    }

    // printf("NDEF 原始数据前 32 字节：\n");
    // for (int i = 0; i < 32; i++) {
    //     printf("%02X ", buffer[i]);
    // }
    // printf("\n");

    // 解析 NDEF Text Record
    uint8_t payloadLen = buffer[4];        // 真实内容长度是 buffer[4]
    uint8_t status     = buffer[6];        // Status Byte 在 buffer[6]
    uint8_t langLen    = status & 0x3F;    // Language code 长度（通常是 2）

    uint8_t *text_start = &buffer[7 + langLen];
    uint8_t text_len = payloadLen - 1 - langLen;

    if (text_len > max_len - 1) text_len = max_len - 1;
    memcpy(out_text, text_start, text_len);
    out_text[text_len] = '\0';

    // printf("提取的文本长度: %d\n", text_len);
    // printf("提取的文本内容: %s\n", out_text);

    return true;
}





/***************************************************************
 * 函数名称: nfc_store_uri_http
 * 说    明: 向NFC写入URI信息
 * 参    数:
 *      @position：信息标识
 *      @http：需要写入的网络地址
 * 返 回 值: 返回ture为成功，false为失败
 ***************************************************************/
bool nfc_store_uri_http(RecordPosEnu position, uint8_t *http)
{
    NDEFDataStr data;
    
    if (m_nfc_is_init == 0)
    {
        printf("%s, %s, %d: NFC is not init!\n", __FILE__, __func__, __LINE__);
        return 0;
    }
    
    prepareUrihttp(&data, position, http);
    return NT3HwriteRecord(&data);
}


/***************************************************************
 * 函数名称: nfc_store_text
 * 说    明: 向NFC写入txt信息
 * 参    数:
 *      @position：信息标识
 *      @http：需要写入的文本信息
 * 返 回 值: 返回ture为成功，false为失败
 ***************************************************************/
bool nfc_store_text(RecordPosEnu position, uint8_t *text)
{
    NDEFDataStr data;
    
    if (m_nfc_is_init == 0)
    {
        printf("%s, %s, %d: NFC is not init!\n", __FILE__, __func__, __LINE__);
        return 0;
    }
    
    prepareText(&data, position, text);
    return NT3HwriteRecord(&data);
}

/***************************************************************
 * 函数名称: nfc_init
 * 说    明: NFC初始化
 * 参    数: 无
 * 返 回 值: 返回0为成功，反之为失败
 ***************************************************************/
unsigned int nfc_init(void)
{
    unsigned int ret = 0;
    uint32_t *pGrf = (uint32_t *)0x41050000U;
    uint32_t ulValue;
    
    if (m_nfc_is_init == 1)
    {
        printf("%s, %s, %d: Nfc readly init!\n", __FILE__, __func__, __LINE__);
        return __LINE__;
    }
    
    ret = NT3HI2cInit();
    if (ret != 0)
    {
        printf("%s, %s, %d: NT3HI2cInit failed!\n", __FILE__, __func__, __LINE__);
        return __LINE__;
    }
    
    m_nfc_is_init = 1;
    return 0;
}


/***************************************************************
 * 函数名称: nfc_deinit
 * 说    明: NFC销毁
 * 参    数: 无
 * 返 回 值: 返回0为成功，反之为失败
 ***************************************************************/
unsigned int nfc_deinit(void)
{
    m_nfc_is_init = 0;
    NT3HI2cDeInit();
    return 0;
}

void nfc_set_state(bool state)
{

    if (state == m_nfc_is_init)
    {
        return;
    }

    if (state)
    {
        nfc_init();
    }
    else
    {
        nfc_deinit();
    } 
    m_nfc_is_init = state;
 
}

int get_nfc_state(void)
{
    return m_nfc_is_init;
}

