# 小说项目简介

## 基本信息

- **书名**：（待填）
- **类型**：（待填）
- **一句话梗概**：（待填）

## 文风约定

- **视角**：第三人称有限 / 第一人称
- **时态**：过去时 / 现在时
- **单章最少汉字**：2000
- **章节文件**：`chapters/001标题.md` 或 `001标题.txt`（三位数字在最前）

## 工作流

1. 在 `plot/chapter-plan.md` 写**本章**大致规划
2. 对 Agent：「按规划写第 N 章」→ 生成 `00N标题.md`（≥2000 字）
3. 你可手改正文 → 「同步 00N」或「重新生成记忆」
4. 章末看 `state/next-chapter.md` 或对话中的 A/B/C，选定后写入下一章 `chapter-plan.md`

## 记忆文件

| 文件 | 作用 |
|------|------|
| `background/core.md` | 根本设定 |
| `plot/digest.md` | 精简剧情 |
| `state/short-term.md` | 最近 5 章（`## 003`） |
| `state/continuity.md` | 当前快照 |
| `state/next-chapter.md` | 下一章选项 |

## 规范

`skills/novel-writing/SKILL.md`、`AGENTS.md`（全 Agent 统一）
