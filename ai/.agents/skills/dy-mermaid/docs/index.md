# Mermaid 图表类型索引

> 这是 Mermaid 所有图表类型的快速参考指南，帮助你根据具体需求选择最合适的图表类型。

**使用场景：**
- 不确定该用哪种图表时，查阅"按场景选择图表"部分
- 需要了解某个图表是否支持 Note 或颜色功能
- 快速查找特定图表的详细文档链接

---

## 图表类型速查表

| 图表 | 关键字 | 用途 | Note | 颜色 | 文档 |
|------|--------|------|------|------|------|
| **流程图** | `flowchart` | 流程、决策、工作流 | ❌ | ✅ classDef/style | [flowchart.md](flowchart.md) |
| **时序图** | `sequenceDiagram` | API调用、消息传递 | ✅ | ✅ rect rgb() | [sequence.md](sequence.md) |
| **类图** | `classDiagram` | OOP设计、类关系 | ✅ | ✅ style | [class.md](class.md) |
| **甘特图** | `gantt` | 项目计划、时间线 | ❌ | ✅ 标签 | [gantt.md](gantt.md) |
| **ER图** | `erDiagram` | 数据库设计 | ❌ | ✅ style | [er.md](er.md) |
| **饼图** | `pie` | 数据占比 | ❌ | ⚠️ 主题 | [pie.md](pie.md) |
| **思维导图** | `mindmap` | 知识结构、头脑风暴 | ❌ | ✅ class | [mindmap.md](mindmap.md) |
| **ZenUML** | `zenuml` | 时序图替代语法 | ✅ // | ⚠️ 有限 | [zenuml.md](zenuml.md) |

## Note 语法支持

仅以下图表支持 Note 注释功能：

| 图表 | Note 语法 |
|------|-----------|
| **Sequence Diagram** | `Note right of A:`, `Note left of A:`, `Note over A,B:` |
| **State Diagram** | `note right of State:`, `note left of State:` |
| **Class Diagram** | `note for ClassName "内容"`, `note "通用内容"` |
| **ZenUML** | `// 单行注释` |

---

## 颜色/样式支持

### 完整支持 (classDef / style)

- Flowchart: `classDef`, `style`, `linkStyle`
- Class Diagram: `style`
- State Diagram: `classDef`
- ER Diagram: `style`
- Block Diagram: `classDef`, `style`
- Requirement Diagram: `classDef`, `style`

### RGB 背景高亮

- Sequence Diagram: `rect rgb(r,g,b)` / `rect rgba(r,g,b,a)`

### 主题变量

- GitGraph: `themeVariables.git0-7`
- XY Chart: `themeVariables.xyChart`
- Quadrant Chart: `themeVariables.quadrant1-4Fill`
- Timeline: `themeVariables.cScale0-n`

### 标签/标记

- Gantt: `done`, `active`, `crit`, `milestone`
- User Journey: 自动根据分数(1-5)着色
- Kanban: `@{ priority: high/medium/low }`
