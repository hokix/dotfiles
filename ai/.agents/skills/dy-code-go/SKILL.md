---
name: dy-code-go
description: 使用AI助手生成代码和单元测试的规范。当要求生成代码、修改代码、审核代码时，请遵循此规范。
---

# 代码风格规范

## Step1 函数注释

```go
// 函数名 简短描述，描述函数的主要功能和返回值
func functionName(param1 Type1, param2 Type2) ReturnType {
    // ...
}
```

## Step2 日志记录

```go
// 函数入口初始化日志上下文
_log := log.L(ctx).With(zap.String("func", "functionName"))

// 记录关键逻辑点
_log.Info("processing started", zap.Int("count", len(items)))
_log.Warn("invalid item", zap.String("reason", "out of range"))
```

**要求**：使用 `log.L(ctx)` 和 `zap` 结构化日志，记录关键输入、输出和中间结果。

## Step3 规则编号

复杂业务逻辑使用编号标记，便于理解和测试：

```go
// 2.2 若该视频没有有效时间段数据,标记为无效
if !exists || len(periods) == 0 {
    return false, 0
}

// 2.3 若标题开始时间 < 第一个有效时间段的开始时间,标记为无效
if startTs < periods[0].PlayStartTime {
    return false, 0
}
```

- 主规则：整数编号（1、2、3...）
- 子规则：小数点编号（2.1、2.2、2.3...）

## Step4 变量命名

- 使用有意义的英文名称
- 避免单字母变量（除循环变量）
- 广为人知的缩写可使用（ctx, msg, id）

## Step5 注释原则

注释说明"为什么"而不是"做什么"。

## Step6 完成前检查

每次代码完成后，进行代码检查，确保符合规范。

# 单元测试规范

## Step1 测试函数结构

```go
func TestFunctionName(t *testing.T) {
    ctx := context.Background()
    s := &Service{}

    // 测试用例1：场景描述
    t.Run("场景描述", func(t *testing.T) {
        // 准备数据
        input := setupTestData()

        // 执行函数
        result := s.FunctionName(ctx, input)

        // 验证结果
        assert.Equal(t, expectedValue, result.Field)
    })
}
```

## Step2 测试用例命名

```
测试用例N：[场景分类]-具体场景描述

场景分类：
- 基本场景：标准正常情况
- 边界情况：等于、大于、小于边界值
- 复杂场景：多个时间段、多个标题组合
- 特殊场景：空数据、缺失数据
```

## Step3 测试数据准备

```go
// 使用具体值并添加注释
vidTimesMap := map[int64][]TimePeriod{
    1001: {
        {
            PlayStartTime: 1744254000, // 2025-04-10 11:00:00
            PlayEndTime:   1744255800, // 2025-04-10 11:30:00
        },
    },
}
```

## Step4 测试断言

```go
// 使用 testify/assert 库并添加清晰的错误消息
assert.Equal(t, 2, result[0].Status, "标题应该被标记为不可用(Status=2)")
assert.Len(t, result, 1, "应该保留1个数据项")
```

## Step5 边界情况测试

必须包含的边界场景：

- 值 < 范围开始 / 值 = 范围开始 / 值 > 范围开始
- 值 < 范围结束 / 值 = 范围结束 / 值 > 范围结束
- 范围之间有间隙 / 无间隙（连续）
- 空数据、单个元素、多个元素

# 代码检查清单

## 代码质量

- [ ] 函数有文档注释
- [ ] 使用结构化日志（log.L(ctx) + zap）
- [ ] 复杂逻辑有规则编号
- [ ] 变量名清晰有意义
- [ ] 所有边界情况已考虑
- [ ] 所有错误情况已处理

## 测试覆盖

- [ ] 基本场景、边界情况、复杂场景都有测试
- [ ] 测试用例命名清晰
- [ ] 测试数据详细有注释
- [ ] 预期结果清晰明确

---

**版本：** 1.0.0
**最后更新：** 2025-12-30
**维护者：** DOUYU
