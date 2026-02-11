# 3 服务端接口

## 3.1 {{MODULE_NAME}}

### 3.1.1 域名

| 环境 | 域名 |
| ---- | ---- |
| live | {{SERVER_LIVE}}     |
| pre  | {{SERVER_PRE}}      |
| prod | {{SERVER_PROD}}     |

### 3.1.2 {{API_NAME}}

| 事项     | 描述 |
| -------- | ---- |
| 接口     | {{API_PATH}}    |
| 对接人   | {{CONTACT_PERSON}} |
| 请求方式 | {{REQUEST_METHOD}}  |

**请求参数**：{{REQUEST_PARAM_TYPE}}

| 参数       | 类型 | 说明 |
| :--------- | :--: | :--: |
| {{PARAM_NAME}} | {{PARAM_TYPE}}  | {{PARAM_DESC}}      |

**返回参数**：json

| 参数  | 类型   | 说明     |
| ----- | ------ | -------- |
| error | int    | 错误码   |
| msg   | string | 错误消息 |
| data  | {{DATA_TYPE}} | {{DATA_DESC}}          |

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
