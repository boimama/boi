import http from '@ohos.net.http';

// 定义接口类型（放在函数外部更清晰）
interface DeviceProperties {
  autoStatus: string;
  humidity: string;
  illumination: string;
  lightStatus: string;
  motorStatus: string;
  nfcStatus: string;
  temperature: string;
}

interface DeviceReported {
  event_time: string;
  properties: DeviceProperties;
}

interface ShadowItem {
  desired: string;
  reported: DeviceReported;
  service_id: string;
  version: number;
}

interface DeviceShadowData {
  device_id: string;
  shadow: ShadowItem[];
}

interface ApiResponse {
  success: boolean;
  data?: DeviceShadowData;
}

// 封装为 Promise 函数
function fetchDeviceData(): Promise<ApiResponse> {
  return new Promise((resolve, reject) => {
    let httpRequest = http.createHttp();

    httpRequest.request(
      'http://10.219.39.214:5000/api/device/shadow', // 修正 URL 错误：原地址中的 "http://http:/" 是错误的
      {
        method: http.RequestMethod.GET
      },
      (err, data) => {
        if (err) {
          console.error('请求失败:', err);
          reject(err);
          return;
        }

        console.info('状态码:', data.responseCode);

        if (typeof data.result === 'string') {
          try {
            const result = JSON.parse(data.result) as ApiResponse;
            resolve(result); // 成功时返回解析后的数据
          } catch (e) {
            console.error('JSON 解析失败');
            reject(e);
          }
        } else {
          reject(new Error('响应结果不是字符串'));
        }
      }
    );
  });
}