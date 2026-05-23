# Agent 说明

本仓库用于本地、长期连载小说。**任意能读文件的 Agent** 使用同一规范，无 IDE 专用分支。

## 规范

**[skills/novel-writing/SKILL.md](skills/novel-writing/SKILL.md)**

## 章节

- `novel/chapters/` · 命名：**三位数字 + 文字**，如 `001序幕.md`、`002风雨.txt`
- 每章 **≥ 2000 汉字**

## 模式

| 模式 | 你说 | Agent 做 |
|------|------|----------|
| 写章 | 按规划写第3章 | 读 `plot/chapter-plan.md` → 写章 → 更新记忆 → 提示下一章 A/B/C |
| 同步 | 同步 003 | 不改正文 → 更新 digest、短期、continuity、人物、关系 |
| 重算记忆 | 重新生成记忆 | 不改正文 → 重建 digest、短期、continuity |

## 记忆（写前读）

| 文件 | 作用 |
|------|------|
| `background/core.md` | 根本设定（locked） |
| `plot/digest.md` | 精简剧情 |
| `state/short-term.md` | 最近 N 章（`## 003`） |
| `state/continuity.md` | 当前快照 |
| `plot/chapter-plan.md` | 本章规划 |
| `state/next-chapter.md` | 下一章选项 |

## 初始化

`skills/novel-writing/scripts/init-novel.ps1`
