# 1 域名

## 1.1 移动端域名

| 环境    |          域名           |
| ----- | :-------------------: |
| live  | {{MOBILE_LIVE}}  |
| trunk | {{MOBILE_TRUNK}} |
| prod  | {{MOBILE_PROD}}   |

## 1.2 web端域名

| 环境  |  域名           |
| -------  |:-------------: |
| live | {{WEB_LIVE}}  |
| trunk | {{WEB_TRUNK}}  |
| prod | {{WEB_PROD}}  |

# 2 toC接口

## 2.1 {{MODULE_NAME}}

### 2.1.1 {{API_NAME}}

**接口要求**:

| 事项     | 描述                        |
| -------- | --------------------------- |
| 移动端接口 | {{MOBILE_API_PATH}} |
| web端接口 | {{WEB_API_PATH}} |
| 对接人   | {{CONTACT_PERSON}}                        |
| 请求方式 | {{REQUEST_METHOD}}                         |
| 是否接口鉴权 | {{REQUIRE_AUTH}} |
| 请求缓存 | {{CACHE_ENABLED}}                          |
| 是否登录 | {{REQUIRE_LOGIN}}                          |
| 是否CSRF | {{CSRF_ENABLED}} |

**请求参数**：{{REQUEST_PARAM_TYPE}}

| 参数       | 类型 | 说明 |
| :--------- | :--: | :--: |
| {{PARAM_NAME}} | {{PARAM_TYPE}}  | {{PARAM_DESC}}     |

**返回参数**：json

| 参数  | 类型   | 说明     |
| ----- | ------ | -------- |
| error | int    | 错误码   |
| msg   | string | 错误消息 |
| data  | {{DATA_TYPE}} | {{DATA_DESC}}         |

消息体

```json
{
    "error": 0,
    "msg": "",
    "data": {
        {{RESPONSE_DATA}}
    }
}
```
