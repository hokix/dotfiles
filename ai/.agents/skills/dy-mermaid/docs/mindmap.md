# Mindmap 思维导图

## 概述

| 属性 | 值 |
|------|-----|
| **关键字** | `mindmap` |
| **用途** | 头脑风暴、知识结构、概念梳理、分类整理 |
| **Note 支持** | ❌ 不支持 |
| **颜色支持** | ✅ `class` 样式类 |

---

## 基础语法

### 声明方式

```mermaid
mindmap
    root((中心主题))
        分支1
        分支2
            子节点A
            子节点B
        分支3
```

**核心规则**: 使用**缩进**表示层级关系

---

## 节点形状

### 默认形状

```mermaid
mindmap
    默认节点
```

### 圆形 (根节点常用)

```mermaid
mindmap
    ((圆形节点))
```

### 圆角矩形

```mermaid
mindmap
    (圆角节点)
```

### 方形

```mermaid
mindmap
    [方形节点]
```

### 爆炸形 (强调)

```mermaid
mindmap
    ))爆炸形((
```

### 云朵形

```mermaid
mindmap
    )云朵形(
```

### 六边形

```mermaid
mindmap
    {{六边形}}
```

### 形状速查表

| 语法 | 形状 | 用途 |
|------|------|------|
| `节点` | 默认 | 普通节点 |
| `((节点))` | 圆形 | 根节点/中心 |
| `(节点)` | 圆角矩形 | 主要分支 |
| `[节点]` | 方形 | 普通节点 |
| `))节点((` | 爆炸形 | 强调/重点 |
| `)节点(` | 云朵形 | 想法/概念 |
| `{{节点}}` | 六边形 | 决策/条件 |

---

## 层级结构

```mermaid
mindmap
    root((项目))
        前端
            Vue
            React
            Angular
        后端
            Java
                Spring Boot
                Spring Cloud
            Python
                Django
                FastAPI
            Go
                Gin
                Echo
        数据库
            MySQL
            Redis
            MongoDB
```

> 关键: 使用**一致的缩进** (空格或Tab)

---

## 图标

### 添加图标

```mermaid
mindmap
    root((开发工具))
        IDE
            ::icon(fa fa-code)
            VS Code
            IntelliJ
        版本控制
            ::icon(fa fa-git)
            Git
            SVN
```

### 图标语法

```text
节点名
    ::icon(图标类名)
```

> 支持 Font Awesome 图标

---

## 样式类 ⭐

### 定义和应用类

```mermaid
mindmap
    root((系统架构))
        前端:::frontend
            Web
            App
        后端:::backend
            API
            Service
        数据:::database
            MySQL
            Redis
```

### 类语法

```text
节点名:::类名
```

---

## Markdown 格式

```mermaid
mindmap
    root((Markdown))
        "`**粗体文本**`"
        "`*斜体文本*`"
        "`~~删除线~~`"
```

> 使用 `` ` `` 包裹 Markdown 语法

---

## 完整示例

### 项目知识结构

```mermaid
mindmap
    root((电商项目))
        用户端
            Web商城
                商品浏览
                购物车
                订单支付
            移动端App
                iOS
                Android
            小程序
                微信
                支付宝
        管理端
            商品管理
                商品发布
                库存管理
                价格管理
            订单管理
                订单查询
                退款处理
                发货管理
            用户管理
                会员管理
                权限配置
        技术架构
            前端技术
                Vue3
                TypeScript
                Element Plus
            后端技术
                Spring Boot
                Spring Cloud
                MyBatis Plus
            中间件
                Redis
                RocketMQ
                Elasticsearch
            数据库
                MySQL
                MongoDB
        部署架构
            开发环境
            测试环境
            生产环境
                K8s集群
                负载均衡
```

### 学习路线图

```mermaid
mindmap
    root((Java开发))
        基础
            Java SE
                语法基础
                面向对象
                集合框架
                IO/NIO
                多线程
                JVM
            数据库
                MySQL
                Redis
            Linux
                常用命令
                Shell脚本
        进阶
            Spring全家桶
                Spring
                Spring MVC
                Spring Boot
                Spring Cloud
            微服务
                服务注册
                服务配置
                服务网关
                服务熔断
            中间件
                消息队列
                搜索引擎
                分布式缓存
        高级
            架构设计
                DDD领域驱动
                微服务架构
                高并发架构
            性能优化
                JVM调优
                SQL优化
                缓存优化
            运维部署
                Docker
                Kubernetes
                CI/CD
```

### 会议头脑风暴

```mermaid
mindmap
    root))问题分析((
        现状
            用户增长缓慢
            转化率低
            复购率不足
        原因分析
            产品问题
                功能不完善
                体验不好
                Bug较多
            运营问题
                推广不足
                活动单一
                用户运营弱
            竞争问题
                竞品多
                价格战
                差异化不明显
        解决方案
            产品优化
                完善核心功能
                提升用户体验
                加强测试质量
            运营加强
                多渠道推广
                丰富活动形式
                建立用户社群
            差异化定位
                深耕细分市场
                打造特色功能
                提升服务质量
```

---

## 常见错误

1. **缩进必须一致**: 使用相同的空格或Tab
   ```text
   ✅ 使用2空格或4空格缩进
   ❌ 混用空格和Tab
   ```

2. **根节点只能有一个**:
   ```text
   ✅ mindmap
          root
              node1
              node2
   ❌ mindmap
          root1
          root2
   ```

3. **形状符号成对**:
   ```text
   ✅ ((圆形))
   ✅ [方形]
   ❌ ((圆形)
   ❌ [方形
   ```

4. **特殊字符使用引号**:
   ```text
   ✅ "包含(括号)的文本"
   ❌ 包含(括号)的文本
   ```

5. **图标行单独一行**: `::icon()` 要单独放一行
   ```text
   ✅ 节点名
          ::icon(fa fa-star)
   ❌ 节点名 ::icon(fa fa-star)
   ```

6. **避免过深嵌套**: 建议不超过5层
