# coding: utf-8

import os
from huaweicloudsdkcore.auth.credentials import BasicCredentials
from huaweicloudsdkcore.auth.credentials import DerivedCredentials
from huaweicloudsdkcore.region.region import Region as coreRegion
from huaweicloudsdkcore.exceptions import exceptions
from huaweicloudsdkiotda.v5 import *
from flask import Flask, request, jsonify

    # The AK and SK used for authentication are hard-coded or stored in plaintext, which has great security risks. It is recommended that the AK and SK be stored in ciphertext in configuration files or environment variables and decrypted during use to ensure security.
    # In this example, AK and SK are stored in environment variables for authentication. Before running this example, set environment variables CLOUD_SDK_AK and CLOUD_SDK_SK in the local environment
ak = 'HPUAGWIUPOAWFJB8CORM'
sk = '758xXMVpn3DJFjyBlBiOP2L0ebB9P9VeBZEcSN7m'
    # ENDPOINT：请在控制台的"总览"界面的"平台接入地址"中查看“应用侧”的https接入地址，下面创建Client时需要使用自行创建的Region对象，基础版：请选择IoTDAClient中的Region对象 如： IoTDAClient.new_builder().with_region(IoTDARegion.CN_NORTH_4)
endpoint = "5285017caf.st1.iotda-app.cn-north-4.myhuaweicloud.com"
device_id = "68559884d582f200183363d9_3333"
credentials = BasicCredentials(ak, sk).with_derived_predicate(DerivedCredentials.get_default_derived_predicate())

client = IoTDAClient.new_builder() \
    .with_credentials(credentials) \
    .with_region(coreRegion(id="cn-north-4", endpoint=endpoint)) \
    .build()
app = Flask(__name__)
@app.route('/api/device/shadow/light_open', methods=['GET'])
def nihao_open():
    try:
        request = UpdateDeviceShadowDesiredDataRequest()
        request.device_id = "68559884d582f200183363d9_3333"
        listShadowbody = [
            UpdateDesired(
                service_id="smartHome",
                desired="{\"lightStatus\":\"ON\"}"
            )
        ]
        request.body = UpdateDesireds(
            shadow=listShadowbody
        )
        response = client.update_device_shadow_desired_data(request)
        return jsonify({
            "success": True,
            "message": "Device shadow updated successfully",
            "response": str(response)
        })
        print(response)
    except exceptions.ClientRequestException as e:
        print(e.status_code)
        print(e.request_id)
        print(e.error_code)
        print(e.error_msg)
@app.route('/api/device/shadow/light_close', methods=['GET'])
def nihao_close():
    try:
        request = UpdateDeviceShadowDesiredDataRequest()
        request.device_id = "68559884d582f200183363d9_3333"
        listShadowbody = [
            UpdateDesired(
                service_id="smartHome",
                desired="{\"lightStatus\":\"OFF\"}"
            )
        ]
        request.body = UpdateDesireds(
            shadow=listShadowbody
        )
        response = client.update_device_shadow_desired_data(request)
        return jsonify({
            "success": True,
            "message": "Device shadow updated successfully",
            "response": str(response)
        })
        print(response)
    except exceptions.ClientRequestException as e:
        print(e.status_code)
        print(e.request_id)
        print(e.error_code)
        print(e.error_msg)
@app.route('/api/device/shadow/motor_close', methods=['GET'])
def nihao_open1():
    try:
        request = UpdateDeviceShadowDesiredDataRequest()
        request.device_id = "68559884d582f200183363d9_3333"
        listShadowbody = [
            UpdateDesired(
                service_id="smartHome",
                desired="{\"motorStatus\":\"OFF\"}"
            )
        ]
        request.body = UpdateDesireds(
            shadow=listShadowbody
        )
        response = client.update_device_shadow_desired_data(request)
        return jsonify({
            "success": True,
            "message": "Device shadow updated successfully",
            "response": str(response)
        })
        print(response)
    except exceptions.ClientRequestException as e:
        print(e.status_code)
        print(e.request_id)
        print(e.error_code)
        print(e.error_msg)
@app.route('/api/device/shadow/motor_open', methods=['GET'])
def nihao_close1():
    try:
        request = UpdateDeviceShadowDesiredDataRequest()
        request.device_id = "68559884d582f200183363d9_3333"
        listShadowbody = [
            UpdateDesired(
                service_id="smartHome",
                desired="{\"motorStatus\":\"ON\"}"
            )
        ]
        request.body = UpdateDesireds(
            shadow=listShadowbody
        )
        response = client.update_device_shadow_desired_data(request)
        return jsonify({
            "success": True,
            "message": "Device shadow updated successfully",
            "response": str(response)
        })
        print(response)
    except exceptions.ClientRequestException as e:
        print(e.status_code)
        print(e.request_id)
        print(e.error_code)
        print(e.error_msg)
@app.route('/api/device/shadow', methods=['GET'])
def get_device_shadow():
    try:
        request = ShowDeviceShadowRequest(device_id=device_id)
        response = client.show_device_shadow(request)
        return jsonify({
            "success": True,
            "data": response.to_json_object()
        })
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)