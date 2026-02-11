# Entity Relationship Diagram (ER图)

## 概述

| 属性 | 值 |
|------|-----|
| **关键字** | `erDiagram` |
| **用途** | 数据库设计、实体关系、表结构设计 |
| **Note 支持** | ❌ 不支持 |
| **颜色支持** | ✅ `style` 样式 |
| **状态** | ⚠️ experimental (实验性) |

---

## 基础语法

### 声明方式

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE-ITEM : contains
```

---

## 实体定义

### 简单实体

```mermaid
erDiagram
    CUSTOMER
    ORDER
    PRODUCT
```

### 带属性的实体

```mermaid
erDiagram
    CUSTOMER {
        int id PK
        string name
        string email UK
        date created_at
    }
```

### 实体别名

```mermaid
erDiagram
    CUSTOMER["客户"] {
        int id
        string name
    }
```

---

## 属性定义

### 属性语法

```text
类型 名称 [PK | FK | UK] ["注释"]
```

### 属性约束

| 约束 | 含义 |
|------|------|
| `PK` | 主键 Primary Key |
| `FK` | 外键 Foreign Key |
| `UK` | 唯一键 Unique Key |

### 属性示例

```mermaid
erDiagram
    USER {
        int id PK "用户ID"
        string username UK "用户名"
        string password "密码"
        int role_id FK "角色外键"
        datetime created_at "创建时间"
    }
```

### 常用数据类型

| 类型 | 说明 |
|------|------|
| `int` / `integer` | 整数 |
| `string` / `varchar` | 字符串 |
| `text` | 长文本 |
| `date` | 日期 |
| `datetime` | 日期时间 |
| `boolean` | 布尔值 |
| `float` / `decimal` | 小数 |

---

## 关系定义

### 关系语法

```text
实体1 [关系符号] 实体2 : "标签"
```

### 关系符号

```mermaid
erDiagram
    A ||--|| B : "一对一"
    C ||--o{ D : "一对多"
    E }o--o{ F : "多对多"
```

### 关系符号速查表

| 左侧 | 右侧 | 含义 |
|------|------|------|
| `\|o` | `o\|` | 零或一 |
| `\|\|` | `\|\|` | 恰好一个 |
| `}o` | `o{` | 零或多个 |
| `}\|` | `\|{` | 一个或多个 |

### 关系线类型

| 符号 | 说明 |
|------|------|
| `--` | 实线 (标识关系) |
| `..` | 虚线 (非标识关系) |

### 完整关系示例

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : "下单"
    ORDER ||--|{ ORDER_ITEM : "包含"
    PRODUCT ||--o{ ORDER_ITEM : "属于"
    CUSTOMER }o--o{ PRODUCT : "收藏"
```

---

## 关系基数详解

### 一对一 (1:1)

```mermaid
erDiagram
    USER ||--|| PROFILE : has
```

### 一对多 (1:N)

```mermaid
erDiagram
    DEPARTMENT ||--o{ EMPLOYEE : "包含"
```

### 多对多 (M:N)

```mermaid
erDiagram
    STUDENT }o--o{ COURSE : "选修"
```

### 零或一

```mermaid
erDiagram
    USER |o--|| CART : "可能有"
```

---

## 样式与颜色 ⭐

### style 直接样式

```mermaid
erDiagram
    CUSTOMER {
        int id PK
        string name
    }
    ORDER {
        int id PK
        int customer_id FK
    }
    CUSTOMER ||--o{ ORDER : places
    
    style CUSTOMER fill:#e3f2fd,stroke:#1565c0
    style ORDER fill:#fff3e0,stroke:#ef6c00
```

---

## 设置方向

```mermaid
erDiagram
    direction LR
    A ||--o{ B : has
```

| 方向 | 说明 |
|------|------|
| `TB` | 从上到下 (默认) |
| `BT` | 从下到上 |
| `LR` | 从左到右 |
| `RL` | 从右到左 |

---

## 完整示例

### 电商系统数据模型

```mermaid
erDiagram
    USER["用户"] {
        bigint id PK "用户ID"
        varchar username UK "用户名"
        varchar password "密码(加密)"
        varchar email UK "邮箱"
        varchar phone "手机号"
        tinyint status "状态: 0禁用 1启用"
        datetime created_at "创建时间"
        datetime updated_at "更新时间"
    }
    
    ADDRESS["地址"] {
        bigint id PK
        bigint user_id FK
        varchar receiver "收货人"
        varchar phone "联系电话"
        varchar province "省"
        varchar city "市"
        varchar district "区"
        varchar detail "详细地址"
        boolean is_default "是否默认"
    }
    
    PRODUCT["商品"] {
        bigint id PK
        varchar name "商品名称"
        text description "商品描述"
        decimal price "价格"
        int stock "库存"
        bigint category_id FK "分类ID"
        tinyint status "状态"
    }
    
    CATEGORY["分类"] {
        bigint id PK
        varchar name "分类名称"
        bigint parent_id FK "父分类ID"
        int sort "排序"
    }
    
    ORDER["订单"] {
        bigint id PK "订单ID"
        varchar order_no UK "订单号"
        bigint user_id FK "用户ID"
        bigint address_id FK "地址ID"
        decimal total_amount "订单总额"
        decimal pay_amount "实付金额"
        tinyint status "订单状态"
        datetime pay_time "支付时间"
        datetime ship_time "发货时间"
        datetime receive_time "收货时间"
        datetime created_at "创建时间"
    }
    
    ORDER_ITEM["订单项"] {
        bigint id PK
        bigint order_id FK
        bigint product_id FK
        varchar product_name "商品名称快照"
        decimal price "商品单价"
        int quantity "数量"
        decimal subtotal "小计"
    }
    
    CART["购物车"] {
        bigint id PK
        bigint user_id FK
        bigint product_id FK
        int quantity "数量"
        boolean selected "是否选中"
    }
    
    USER ||--o{ ADDRESS : "拥有"
    USER ||--o{ ORDER : "下单"
    USER ||--|| CART : "购物车"
    ORDER ||--|{ ORDER_ITEM : "包含"
    ORDER }o--|| ADDRESS : "配送至"
    PRODUCT ||--o{ ORDER_ITEM : "购买"
    PRODUCT ||--o{ CART : "加购"
    CATEGORY ||--o{ PRODUCT : "包含"
    CATEGORY ||--o{ CATEGORY : "子分类"
```

### 博客系统

```mermaid
erDiagram
    USER {
        int id PK
        string username UK
        string email UK
        string password
        string avatar
        datetime created_at
    }
    
    POST {
        int id PK
        int author_id FK
        string title
        text content
        int status
        int view_count
        datetime published_at
        datetime created_at
    }
    
    COMMENT {
        int id PK
        int post_id FK
        int user_id FK
        int parent_id FK
        text content
        datetime created_at
    }
    
    TAG {
        int id PK
        string name UK
        string slug UK
    }
    
    POST_TAG {
        int post_id FK
        int tag_id FK
    }
    
    USER ||--o{ POST : "发布"
    USER ||--o{ COMMENT : "评论"
    POST ||--o{ COMMENT : "包含"
    COMMENT ||--o{ COMMENT : "回复"
    POST ||--o{ POST_TAG : ""
    TAG ||--o{ POST_TAG : ""
```

---

## 常见错误

1. **实体名全大写**: 约定使用大写
   ```text
   ✅ CUSTOMER
   ⚠️ Customer  # 可以但不推荐
   ```

2. **关系标签必须有**: 冒号后需要标签（可以是空字符串）
   ```text
   ✅ A ||--o{ B : "包含"
   ✅ A ||--o{ B : ""
   ❌ A ||--o{ B
   ```

3. **属性类型不能有空格**:
   ```text
   ✅ varchar name
   ❌ var char name
   ```

4. **关系符号配对**:
   - 左侧用 `||`, `}|`, `}o`, `|o`
   - 右侧用 `||`, `|{`, `o{`, `o|`

5. **实体名中避免特殊字符**: 使用下划线
   ```text
   ✅ ORDER_ITEM
   ❌ ORDER-ITEM  # 连字符可能有问题
   ```
