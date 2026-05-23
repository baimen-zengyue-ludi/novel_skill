# 安装（任意 Agent）

## 原则

- **规范**：`skills/novel-writing/SKILL.md`
- **数据**：`novel/`
- 不依赖 `.cursor` 或任何 IDE 专有目录。

## 加载

| 方式 | 说明 |
|------|------|
| `AGENTS.md` | 仓库根入口 |
| `SKILL.md` 全文 | 注入 system prompt |
| `@skills/novel-writing/SKILL.md` | IDE 内引用路径 |

## 推荐 system 片段

```
遵循 skills/novel-writing/SKILL.md 与 AGENTS.md。数据在 novel/。

章节：chapters/ 下 三位数字+文字.md 或 .txt，如 001序幕.md。每章至少 2000 汉字。

写章：读 plot/chapter-plan.md → 生成章节 → 更新 digest、short-term、continuity、人物、关系、tasks → 更新 state/next-chapter.md 并在对话给出下一章 A/B/C/自定义。
同步：「同步 003」→ 不改正文，按正文回写记忆。
重算：「重新生成记忆」→ 不改正文，按各章重建 digest 与短期记忆。

写前必读：background/core.md、plot/digest.md、state/short-term.md、state/continuity.md。
不得改 core.md，除非用户明确「修订根本设定」。
```

## 复制到其他项目

复制 `skills/novel-writing/` 与 `AGENTS.md`，运行 `init-novel.ps1`。

## 自建 API（Python）

```python
from pathlib import Path

ROOT = Path(".")
system = (ROOT / "skills/novel-writing/SKILL.md").read_text(encoding="utf-8")

def memory_context(novel=ROOT / "novel"):
    files = [
        "background/core.md", "plot/digest.md", "state/short-term.md",
        "state/continuity.md", "plot/chapter-plan.md",
    ]
    return "\n\n".join((novel / f).read_text(encoding="utf-8") for f in files)
```

## 更新 Skill 后

修改 `skills/novel-writing/`；已有 `novel/` 可再跑 `init-novel.ps1` 补缺失模板文件。
