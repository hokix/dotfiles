# Class Diagram 类图

## 概述

| 属性 | 值 |
|------|-----|
| **关键字** | `classDiagram` |
| **用途** | 面向对象设计、类关系、数据模型 |
| **Note 支持** | ✅ `note for <类名>` / `note "内容"` |
| **颜色支持** | ✅ `style` + `classDef` |

---

## 基础语法

### 声明方式

```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +makeSound()
    }
```

---

## 定义类

### 方式1: 大括号定义

```mermaid
classDiagram
    class User {
        +Long id
        +String username
        -String password
        #String email
        +login() bool
        +logout() void
        -hashPassword(String) String
    }
```

### 方式2: 冒号定义 (单行)

```mermaid
classDiagram
    class Order
    Order : +Long orderId
    Order : +Date createTime
    Order : +getTotal() BigDecimal
```

---

## 可见性修饰符

| 符号 | 含义 | Java等价 |
|------|------|----------|
| `+` | public | public |
| `-` | private | private |
| `#` | protected | protected |
| `~` | package/internal | default |

### 示例

```mermaid
classDiagram
    class MyClass {
        +publicField
        -privateField
        #protectedField
        ~packageField
        +publicMethod()
        -privateMethod()
    }
```

---

## 方法修饰符

| 符号 | 含义 | 位置 |
|------|------|------|
| `*` | 抽象方法 | 方法末尾 |
| `$` | 静态方法/字段 | 方法/字段末尾 |

```mermaid
classDiagram
    class AbstractService {
        <<abstract>>
        +String name$
        +getInstance()$ AbstractService
        +process()* void
    }
```

---

## 类关系

### 关系类型速查表

| 语法 | 名称 | 说明 | 示例 |
|------|------|------|------|
| `<\|--` | 继承 Inheritance | 子类继承父类 | Dog继承Animal |
| `*--` | 组合 Composition | 强关联,整体销毁部分也销毁 | Car包含Engine |
| `o--` | 聚合 Aggregation | 弱关联,整体与部分独立 | Team包含Player |
| `-->` | 关联 Association | 普通关联 | Student关联Course |
| `--` | 链接 Link | 实线连接 | - |
| `..>` | 依赖 Dependency | 使用关系 | Client依赖Service |
| `..\|>` | 实现 Realization | 实现接口 | UserService实现IService |
| `..` | 虚线链接 | 虚线连接 | - |

### 关系示例

```mermaid
classDiagram
    Animal <|-- Dog : 继承
    Animal <|-- Cat : 继承
    
    Car *-- Engine : 组合
    Car *-- Wheel : 组合
    
    Team o-- Player : 聚合
    
    Student --> Course : 关联
    
    Client ..> Service : 依赖
    
    IRepository <|.. UserRepository : 实现
```

---

## 关系标签和基数

### 关系标签

```mermaid
classDiagram
    Customer "1" --> "*" Order : 下单
    Order "1" --> "1..*" OrderItem : 包含
    OrderItem "*" --> "1" Product : 关联
```

### 基数 (多重性)

| 符号 | 含义 |
|------|------|
| `1` | 恰好一个 |
| `0..1` | 零个或一个 |
| `1..*` | 一个或多个 |
| `*` | 零个或多个 |
| `n` | n个 |
| `0..n` | 零到n个 |
| `1..n` | 一到n个 |

---

## 注解 Annotation

```mermaid
classDiagram
    class IService {
        <<interface>>
        +process() void
    }
    
    class AbstractHandler {
        <<abstract>>
        +handle()* void
    }
    
    class OrderService {
        <<service>>
        +createOrder()
    }
    
    class Color {
        <<enumeration>>
        RED
        GREEN
        BLUE
    }
```

### 常用注解

| 注解 | 用途 |
|------|------|
| `<<interface>>` | 接口 |
| `<<abstract>>` | 抽象类 |
| `<<service>>` | 服务类 |
| `<<enumeration>>` | 枚举 |
| `<<entity>>` | 实体类 |

---

## 泛型

```mermaid
classDiagram
    class List~T~ {
        +add(T item) void
        +get(int index) T
    }
    
    class Map~K,V~ {
        +put(K key, V value) void
        +get(K key) V
    }
    
    List~User~ <-- UserService
```

> 注意: 使用 `~T~` 代替 `<T>`

---

## 命名空间 Namespace

```mermaid
classDiagram
    namespace Domain {
        class User {
            +id
            +name
        }
        class Order {
            +orderId
        }
    }
    
    namespace Service {
        class UserService {
            +getUser()
        }
    }
    
    UserService --> User
```

---

## Note 注释 ⭐

### 为类添加注释

```mermaid
classDiagram
    class User {
        +id
        +name
    }
    note for User "这是用户实体类<br/>用于存储用户信息"
```

### 通用注释

```mermaid
classDiagram
    class A
    class B
    note "这是通用注释<br/>描述整体设计"
```

---

## 样式与颜色 ⭐

### style 直接样式

```mermaid
classDiagram
    class User {
        +id
        +name
    }
    class Order {
        +orderId
    }
    
    style User fill:#e1f5fe,stroke:#0288d1
    style Order fill:#fff3e0,stroke:#f57c00
```

### classDef 类定义

```mermaid
classDiagram
    class User
    class Admin
    class Guest
    
    classDef entity fill:#e8f5e9,stroke:#2e7d32
    classDef admin fill:#ffebee,stroke:#c62828
    
    class User entity
    class Admin admin
```

---

## 设置方向

```mermaid
classDiagram
    direction LR
    class A
    class B
    A --> B
```

| 方向 | 说明 |
|------|------|
| `TB` | 从上到下 (默认) |
| `BT` | 从下到上 |
| `LR` | 从左到右 |
| `RL` | 从右到左 |

---

## 完整示例

### 电商系统类图

```mermaid
classDiagram
    direction TB
    
    class User {
        <<entity>>
        -Long id
        -String username
        -String password
        -String email
        +login() boolean
        +logout() void
    }
    
    class Order {
        <<entity>>
        -Long orderId
        -Date createTime
        -BigDecimal totalAmount
        -OrderStatus status
        +calculateTotal() BigDecimal
        +cancel() void
    }
    
    class OrderItem {
        <<entity>>
        -Long itemId
        -Integer quantity
        -BigDecimal price
    }
    
    class Product {
        <<entity>>
        -Long productId
        -String name
        -BigDecimal price
        -Integer stock
    }
    
    class OrderStatus {
        <<enumeration>>
        PENDING
        PAID
        SHIPPED
        COMPLETED
        CANCELLED
    }
    
    class IOrderService {
        <<interface>>
        +createOrder(User, List~OrderItem~)* Order
        +cancelOrder(Long)* void
    }
    
    class OrderServiceImpl {
        <<service>>
        +createOrder(User, List~OrderItem~) Order
        +cancelOrder(Long) void
    }
    
    User "1" --> "*" Order : 下单
    Order "1" *-- "1..*" OrderItem : 包含
    OrderItem "*" --> "1" Product : 关联
    Order --> OrderStatus : 状态
    IOrderService <|.. OrderServiceImpl : 实现
    OrderServiceImpl ..> Order : 使用
    
    note for User "用户实体"
    note for Order "订单实体<br/>包含多个订单项"
    
    style User fill:#e3f2fd,stroke:#1565c0
    style Order fill:#fff3e0,stroke:#ef6c00
    style Product fill:#e8f5e9,stroke:#2e7d32
    style IOrderService fill:#f3e5f5,stroke:#7b1fa2
```

---

## 常见错误

1. **泛型使用波浪号**: `List~T~` 而不是 `List<T>`

2. **关系箭头方向**: 箭头指向被依赖方
   ```text
   Client --> Service  # Client 依赖 Service
   ```

3. **成员定义缩进**: 大括号内的成员需要正确缩进

4. **特殊字符转义**: 类名和方法名避免特殊字符

5. **note 语法**: 使用 `note for 类名 "内容"` 格式
