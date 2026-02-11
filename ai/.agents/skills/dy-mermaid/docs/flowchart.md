# Flowchart 流程图

## 概述

| 属性 | 值 |
|------|-----|
| **关键字** | `flowchart` 或 `graph` |
| **用途** | 流程、决策树、工作流、系统架构 |
| **Note 支持** | ❌ 不支持（可用特殊节点模拟） |
| **颜色支持** | ✅ `classDef` + `style` |

---

## 基础语法

### 声明方式

```mermaid
flowchart LR
    A --> B
```

### 方向

| 方向 | 含义 |
|------|------|
| `TB` / `TD` | 从上到下 (Top to Bottom / Top-Down) |
| `BT` | 从下到上 (Bottom to Top) |
| `LR` | 从左到右 (Left to Right) |
| `RL` | 从右到左 (Right to Left) |

---

## 节点形状

```mermaid
flowchart LR
    A[矩形]
    B(圆角矩形)
    C([体育场形])
    D[[子程序]]
    E[(数据库/圆柱)]
    F((圆形))
    G>旗帜形]
    H{菱形/决策}
    I{{六边形}}
    J[/平行四边形/]
    K[\平行四边形alt\]
    L[/梯形\]
    M[\梯形alt/]
    N(((双圆)))
```

### 节点形状速查表

| 语法 | 形状 | 用途 |
|------|------|------|
| `A[文本]` | 矩形 | 普通步骤 |
| `A(文本)` | 圆角矩形 | 普通步骤 |
| `A([文本])` | 体育场形 | 开始/结束 |
| `A[[文本]]` | 子程序形 | 子流程 |
| `A[(文本)]` | 圆柱形 | 数据库 |
| `A((文本))` | 圆形 | 开始/结束 |
| `A>文本]` | 旗帜形 | 特殊标记 |
| `A{文本}` | 菱形 | 决策/判断 |
| `A{{文本}}` | 六边形 | 条件准备 |
| `A[/文本/]` | 平行四边形 | 输入/输出 |
| `A[\文本\]` | 平行四边形(反) | 输入/输出 |
| `A[/文本\]` | 梯形 | 手动操作 |
| `A[\文本/]` | 梯形(反) | 优先操作 |
| `A(((文本)))` | 双圆形 | 结束点 |

---

## 连接线/箭头

### 箭头类型

```mermaid
flowchart LR
    A --> B
    C --- D
    E -.-> F
    G ==> H
    I --文本--> J
    K -.文本.-> L
    M ==文本==> N
```

### 连接线速查表

| 语法 | 说明 |
|------|------|
| `-->` | 带箭头实线 |
| `---` | 无箭头实线 |
| `-.->` | 带箭头虚线 |
| `-.-` | 无箭头虚线 |
| `==>` | 带箭头粗线 |
| `===` | 无箭头粗线 |
| `--文本-->` | 带文本箭头 |
| `-- 文本 ---` | 带文本无箭头 |
| `-.文本.->` | 虚线带文本 |
| `==文本==>` | 粗线带文本 |
| `~~~` | 不可见连接（用于布局） |

### 双向箭头

```mermaid
flowchart LR
    A <--> B
    C o--o D
    E x--x F
```

---

## 子图 Subgraph

```mermaid
flowchart TB
    subgraph 用户端
        A[浏览器] --> B[App]
    end
    subgraph 服务端
        C[API网关] --> D[微服务]
    end
    B --> C
```

### 子图语法

```text
subgraph 标题
    节点定义...
end
```

### 子图方向

```mermaid
flowchart LR
    subgraph 子图标题
        direction TB
        A --> B
    end
```

---

## 样式与颜色

### 方式1: style 直接样式

```mermaid
flowchart LR
    A[开始] --> B[处理] --> C[结束]
    style A fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style B fill:#fff3e0,stroke:#e65100
    style C fill:#e8f5e9,stroke:#1b5e20
```

**style 语法**:
```text
style 节点ID fill:颜色,stroke:边框色,stroke-width:边框宽,color:文字色
```

### 方式2: classDef 类定义

```mermaid
flowchart LR
    A[开始]:::startEnd --> B[处理]:::process --> C[结束]:::startEnd
    
    classDef startEnd fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef process fill:#fff3e0,stroke:#ef6c00
```

**classDef 语法**:
```text
classDef 类名 fill:颜色,stroke:边框色,stroke-width:边框宽,color:文字色
```

**应用类的两种方式**:
```text
%% 方式1: 声明时使用 :::
A[文本]:::类名

%% 方式2: 单独声明
class A,B,C 类名
```

### 连接线样式

```mermaid
flowchart LR
    A --> B --> C
    linkStyle 0 stroke:#ff0000,stroke-width:3px
    linkStyle 1 stroke:#00ff00,stroke-width:2px,stroke-dasharray:5
```

**linkStyle 语法**:
```text
linkStyle 索引 stroke:颜色,stroke-width:宽度
```
> 注意: 索引从 0 开始，按连接线出现顺序计数

---

## 完整示例

### 订单处理流程

```mermaid
flowchart TD
    A([开始]) --> B{订单有效?}
    B -->|是| C[检查库存]
    B -->|否| D[返回错误]
    C --> E{库存充足?}
    E -->|是| F[创建订单]
    E -->|否| G[通知缺货]
    F --> H[(保存到数据库)]
    H --> I([结束])
    D --> I
    G --> I
    
    classDef startEnd fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    classDef decision fill:#fff3e0,stroke:#ef6c00,stroke-width:2px
    classDef process fill:#e3f2fd,stroke:#1565c0
    classDef error fill:#ffebee,stroke:#c62828
    classDef database fill:#f3e5f5,stroke:#7b1fa2
    
    class A,I startEnd
    class B,E decision
    class C,F process
    class D,G error
    class H database
```

---

## 常见错误

1. **特殊字符需转义**: 使用 `"` 包含特殊字符
   ```mermaid
   flowchart LR
       A["包含(括号)的文本"]
   ```

2. **节点ID不能有空格**: 使用驼峰或下划线
   ```text
   ❌ my node[文本]
   ✅ myNode[文本]
   ✅ my_node[文本]
   ```

3. **子图标题不能为空**: subgraph 后必须有标题

4. **linkStyle索引从0开始**: 第一条连接线是索引0
