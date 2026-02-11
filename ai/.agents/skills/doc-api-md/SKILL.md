---
name: doc-api-md
description: Generate structured API documentation in Markdown format following a standardized template. Use when users need to create or document API interfaces including toC (client-facing) APIs or server-to-server APIs. Supports generating documentation with domains, endpoints, request/response schemas, and authentication requirements.
---

# API Documentation Generator

Generate comprehensive API documentation following a standardized Markdown format.

## Supported Documentation Types

1. **toC Interfaces**: Client-facing APIs (mobile and web)
2. **Server Interfaces**: Server-to-server APIs

## Quick Start

When a user requests API documentation, ask for the necessary details:

- API type (toC or server)
- Module name and API name
- Endpoint path
- Request method (GET, POST, PUT, DELETE, etc.)
- Request parameters with types and descriptions
- Response data structure
- Authentication requirements
- Contact person

Then generate the documentation using the appropriate template from `assets/`.

## toC Interface Documentation

For client-facing APIs, use `assets/toc_template.md` template. Include:

**Required information**:
- Domain configuration (mobile and web for live/trunk/prod environments)
- API endpoint paths (mobile and web versions)
- Contact person
- Request method
- Authentication requirements (接口鉴权, 是否登录, 是否CSRF)
- Cache settings
- Request parameters (name, type, description)
- Response structure

**Template structure**:
```markdown
# 1 域名
## 1.1 移动端域名
## 1.2 web端域名

# 2 toC接口
## 2.1 [模块名]
### 2.1.1 [接口名]
```

## Server Interface Documentation

For server-to-server APIs, use `assets/server_template.md` template. Include:

**Required information**:
- Server domain configuration (live/pre/prod environments)
- API endpoint path
- Contact person
- Request method
- Request parameters (name, type, description)
- Response structure

**Template structure**:
```markdown
# 3 服务端接口
## 3.1 [模块名]
### 3.1.1 域名
### 3.1.2 [接口]
```

## Response Format

Both templates use a standardized JSON response format:
```json
{
    "error": 0,
    "msg": "",
    "data": {}
}
```

## Workflow

1. Identify the API type (toC or server)
2. Read the appropriate template from `assets/`
3. Gather required information from user (ask if not provided)
4. Replace template placeholders with actual values
5. Generate complete documentation

## Default Values

Use these defaults when information is not provided:

- Request method: `GET`
- Request param type: `query`
- 是否接口鉴权: `否`
- 请求缓存: `否`
- 是否登录: `否`
- 是否CSRF: `否`
