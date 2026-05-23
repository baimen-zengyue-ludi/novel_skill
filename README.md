# novel_skill

跨 **任意 Agent** 的本地小说仓库：规范只在 `skills/novel-writing/`。

## 能力

| 能力 | 说明 |
|------|------|
| Agent 写章 | 填 `plot/chapter-plan.md`，Agent 写 ≥2000 字并维护记忆 |
| 手改后同步 | 改 `chapters/` →「同步 003」 |
| 重算记忆 | 「重新生成记忆」→ 不改正文，重建 digest / 短期 |
| 章末续写 | Agent 给出下一章 A/B/C/自定义 |
| 章节命名 | `001标题.md` / `002标题.txt` |

## 快速开始

```powershell
cd ..\novel_skill
powershell -ExecutionPolicy Bypass -File skills/novel-writing/scripts/init-novel.ps1
```

对任意 Agent：

```
遵循 skills/novel-writing/SKILL.md 与 AGENTS.md；数据在 novel/。
```

1. 填 `novel/background/core.md`
2. 填 `novel/plot/chapter-plan.md`
3. 「按规划写第 1 章」

## 目录

| 路径 | 用途 |
|------|------|
| `skills/novel-writing/` | **唯一** Skill 规范 |
| `AGENTS.md` | Agent 入口 |
| `novel/` | 小说数据 |

## 文档

- [skills/novel-writing/SKILL.md](skills/novel-writing/SKILL.md)
- [skills/novel-writing/reference.md](skills/novel-writing/reference.md)
- [skills/novel-writing/install.md](skills/novel-writing/install.md)
