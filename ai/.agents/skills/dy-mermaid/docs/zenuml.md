# ZenUML 时序图

## 概述

| 属性 | 值 |
|------|-----|
| **关键字** | `zenuml` |
| **用途** | 时序图的替代语法，更接近编程风格 |
| **Note 支持** | ✅ `// comment` 行注释 |
| **颜色支持** | ❌ 有限 |

---

## 基础语法

### 声明方式

```mermaid
zenuml
    Alice->Bob: Hello
    Bob->Alice: Hi
```

**特点**: 使用更接近编程语言的语法

---

## 参与者

### 隐式声明

```mermaid
zenuml
    Client->Server: request
    Server->Database: query
```

### 显式声明

```mermaid
zenuml
    @Actor Alice
    @Database DB
    
    Alice->DB: query
    DB->Alice: result
```

### 参与者注解

| 注解 | 说明 |
|------|------|
| `@Actor` | 人物角色 |
| `@Boundary` | 边界 |
| `@Control` | 控制器 |
| `@Entity` | 实体 |
| `@Database` | 数据库 |
| `@Collection` | 集合 |
| `@Queue` | 队列 |

### 别名

```mermaid
zenuml
    @Actor "用户" as User
    @Database "数据库" as DB
    
    User->DB: 查询
```

---

## 消息类型

### 同步消息

```mermaid
zenuml
    A.method()
    A->B: message
```

### 异步消息

```mermaid
zenuml
    A->>B: async message
```

### 返回消息

```mermaid
zenuml
    A->B.method() {
        return result
    }
```

---

## 方法调用风格

### 函数调用

```mermaid
zenuml
    Client->Server.login(username, password) {
        Server->Database.findUser(username) {
            return user
        }
        return token
    }
```

### 嵌套调用

```mermaid
zenuml
    A->B.step1() {
        B->C.step2() {
            C->D.step3() {
                return "done"
            }
        }
    }
```

---

## 注释 ⭐

```mermaid
zenuml
    // 这是单行注释
    A->B: request
    // 处理请求
    B->C: process
```

---

## 控制流

### 循环 loop/while/for

```mermaid
zenuml
    A->B: check
    while(condition) {
        B->C: process
    }
```

```mermaid
zenuml
    for(i in items) {
        A->B: process item
    }
```

### 条件 if/else

```mermaid
zenuml
    A->B.validate() {
        if(valid) {
            B->C: process
            return success
        } else {
            return error
        }
    }
```

### try/catch/finally

```mermaid
zenuml
    try {
        A->B: risky operation
    } catch(Exception) {
        A->C: handle error
    } finally {
        A->D: cleanup
    }
```

### 可选 opt

```mermaid
zenuml
    A->B: request
    opt {
        B->C: optional step
    }
    B->A: response
```

### 并行 par

```mermaid
zenuml
    par {
        A->B: task1
        A->C: task2
    }
```

---

## 完整示例

### 用户登录流程

```mermaid
zenuml
    @Actor "用户" as User
    @Boundary "前端" as Frontend
    @Control "认证服务" as Auth
    @Database "数据库" as DB
    
    // 用户发起登录
    User->Frontend.login(username, password) {
        // 前端验证
        Frontend->Auth.authenticate(username, password) {
            // 查询用户
            Auth->DB.findByUsername(username) {
                return user
            }
            
            if(passwordMatch) {
                // 生成Token
                Auth->Auth.generateToken(user)
                return token
            } else {
                return "401 Unauthorized"
            }
        }
        return response
    }
```

### 订单处理

```mermaid
zenuml
    @Actor Customer
    @Boundary WebApp
    @Control OrderService
    @Entity Product
    @Database OrderDB
    
    Customer->WebApp.submitOrder(cart) {
        WebApp->OrderService.createOrder(cart) {
            // 检查库存
            for(item in cart.items) {
                OrderService->Product.checkStock(item) {
                    if(outOfStock) {
                        return "库存不足"
                    }
                }
            }
            
            // 创建订单
            OrderService->OrderDB.save(order)
            
            // 扣减库存
            try {
                for(item in cart.items) {
                    OrderService->Product.decreaseStock(item)
                }
            } catch(Exception) {
                OrderService->OrderDB.rollback()
                return "下单失败"
            }
            
            return order
        }
    }
```

### API调用

```mermaid
zenuml
    Client->Gateway.request(data) {
        // 认证检查
        Gateway->AuthService.verify(token) {
            if(!valid) {
                return "401"
            }
        }
        
        // 限流检查
        Gateway->RateLimiter.check(clientId) {
            if(exceeded) {
                return "429"
            }
        }
        
        // 路由到后端
        par {
            Gateway->ServiceA.process(data)
            Gateway->ServiceB.process(data)
        }
        
        return response
    }
```

---

## 与 sequenceDiagram 对比

| 特性 | sequenceDiagram | zenuml |
|------|-----------------|--------|
| 语法风格 | 声明式 | 编程式 |
| 函数调用 | 不支持 | ✅ 支持 |
| 嵌套结构 | alt/else/end | if/else + {} |
| 循环 | loop...end | while/for + {} |
| 颜色高亮 | rect rgb() | ❌ 有限 |
| Note | Note over/right/left | // 注释 |

---

## 常见错误

1. **使用大括号嵌套**: 不是 `end`
   ```text
   ✅ if(condition) { ... }
   ❌ if(condition) ... end
   ```

2. **返回值语法**:
   ```text
   ✅ return result
   ❌ -->> result
   ```

3. **注解格式**: 使用 `@`
   ```text
   ✅ @Actor User
   ❌ actor User
   ```

4. **方法调用**: 使用点号
   ```text
   ✅ A->B.method()
   ✅ A.method()
   ```

5. **别名**: 使用 `as`
   ```text
   ✅ @Actor "用户" as User
   ```
