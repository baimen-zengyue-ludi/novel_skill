# 小说项目参考

## meta.yaml

```yaml
title: 书名
author: 作者
genre: 玄幻
language: zh-CN
chapter_format: md          # md | txt，全书统一
next_chapter: 1
min_chars_per_chapter: 2000   # 每章最少汉字数
writing_mode: hybrid
memory_window_chapters: 5
default_pov: protagonist-id
background_required_tags:
  - 根本
  - 世界观
created: YYYY-MM-DD
updated: YYYY-MM-DD
```

## 章节命名

| 项 | 规则 |
|----|------|
| 模式 | `^\d{3}.+\.(md\|txt)$` |
| 章号 | 文件名最前 3 位数字，如 `007` |
| 示例 | `001开篇.md`、`012-终局.txt` |
| 禁止 | `ch001-` 前缀 |

按数字排序读章：`Sort-Object { [int]$_.Name.Substring(0,3) }`

## plot/chapter-plan.md（当前章规划）

用户给 Agent 的**本章**粗略意图即可（不必写正文）：

```markdown
# 当前章规划

- 章号：003
- 建议标题关键词：雨中相遇
- 要点：
  1. …
  2. …
- 必出场人物：id-a, id-b
- 本章禁止：…（可选）
```

写完后可清空要点或保留作档案；下一章规划由用户根据 `next-chapter.md` 填写。

## state/next-chapter.md

```markdown
# 下一章建议

> 在 003《…》之后 | 建议写第 004 章

## 选项 A
…

## 选项 B
…

## 选项 C
…

## 用户选择
- [ ] 待选 | 已选：A | 自定义：…
```

Agent 必须在**对话**中复述选项，不能只写文件。

## 短期记忆节标题

使用 `## 003`（三位数字），与文件名章号一致，不用 `ch003`。

## 模式 C：重算记忆

1. 列出 `chapters/` 下所有合法章节，按章号排序。
2. 自 `001` 起顺序读正文，重建 `digest`（全书）、`short-term`（仅保留最近 N 章节）、`continuity`（当前）。
3. 同步 `relationships`、人物卡、`tasks` 与正文一致。
4. **不**修改章节文件；输出变更摘要。

触发词：`重新生成记忆`、`重算记忆`、`从第1章重建摘要`。

## 模式 B：同步单章

触发词：`同步 003`、`003 改好了`。

以该章正文为权威，更新 L1–L3 及人物关系；若与旧 digest 冲突，以正文为准。

## 字数统计

- 统计**正文**汉字（不含 frontmatter、标题行可按工具约定剔除）。
- Agent 生成未 ≥ `min_chars_per_chapter` 不得标记章后流程完成。

## 冲突优先级

`core.md` > canon 背景 > `digest` > `short-term` > `continuity` > 正文草稿

已定稿 `status: final` 的正文在与 digest 冲突时，先报告用户，再决定改 digest 还是改正文。

## 加载

`skills/novel-writing/SKILL.md` + `AGENTS.md`，任意 Agent 相同。
