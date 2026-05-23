# 背景资料索引

> Agent：写章前根据 **canon**、**标签**、**spoiler** 列加载文件；新增 md/txt 后必须在本表登记。

## 登记

| 文件 | 格式 | 标签 | canon | 摘要 | 备注 |
|------|------|------|-------|------|------|
| core.md | md | 根本 | true | 不可变根本设定 | locked，全书必读 |
| world.md | md | 世界观 | true | 世界总述、时代、核心规则 | 全书必读 |
| history.md | md | 历史 | true | 大事件年表 | |
| factions.md | md | 势力 | true | 主要势力与关系 | |
| locations.md | md | 地理 | true | 重要地点 | |
| imports/ | — | — | — | 用户导入的原始资料目录 | 见该目录下文件 |

## 按标签

### 根本（L0，必读）

- core.md

### 世界观

- world.md

### 历史

- history.md

### 势力

- factions.md

### 地理

- locations.md

## 导入说明

1. 将 `.txt` / `.md` 放入 `imports/` 或本目录。
2. 在上表新增一行；txt 的 canon 默认 `false` 直至你审核改为 `true`。
3. 与人物卡、`plot/outline.md` 冲突时，以 **canon=true** 的背景为准，或询问用户。
