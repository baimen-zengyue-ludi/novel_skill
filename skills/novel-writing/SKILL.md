---
name: novel-writing
description: >-
  跨 Agent 本地小说：章节文件名为三位数字+文字（md/txt）；每章≥2000汉字；Agent按规划写章、
  改稿后同步或重算记忆；章末给出下一章选项。写小说、同步章节、长期连载时使用。
---

# 本地小说写作 Skill

## 加载（任意 Agent）

- **规范**：`skills/novel-writing/SKILL.md`（本文件）
- **入口**：仓库根 `AGENTS.md`
- **数据**：`novel/`（默认）

将本文件或 `AGENTS.md` 注入 system；工作目录为仓库根。**事实只以 `novel/` 文件为准**，不用对话记忆覆盖。

---

## 章节命名（md / txt 相同）

路径：`novel/chapters/`

| 规则 | 说明 |
|------|------|
| 格式 | **`{三位数字}{文字标题}.{md\|txt}`** |
| 数字 | 文件名**最前**三位，如 `001`、`012` |
| 文字 | 紧跟数字，或 `数字-` 后接标题 |
| 扩展名 | `.md` 或 `.txt`，全书统一 |

示例：`001序幕.md`、`002-入城.txt`、`015终章.md`  
**不用** `ch001-` 前缀。章号 = 文件名前三位数字。

---

## 字数

- 每章 **≥ 2000 汉字**（`meta.yaml` → `min_chars_per_chapter`，默认 2000）
- Agent 生成未达标须续写后再做章后流程
- 同步/重算时若不足，仅提醒，**不擅自改正文**

---

## 工作模式

| 模式 | 触发语 | Agent 行为 |
|------|--------|------------|
| **A · 写章** | 写第3章、按规划写 003 | 读 `plot/chapter-plan.md` → 生成 `003….md`（≥2000字）→ 更新记忆 → **对话给出下一章 A/B/C** |
| **B · 同步** | 同步 003、003 改好了 | **不改正文** → 从该章提取事实 → 更新 digest / 短期 / continuity / 人物 / 关系 / tasks |
| **C · 重算记忆** | 重新生成记忆 | **不改正文** → 按各章顺序重建 digest、短期（滚窗）、continuity 等 |
| **D · 混合** | 只写某场景 | 只改指定内容；完成后走 B 或 C |

`meta.yaml` → `writing_mode`：`agent` | `human` | `hybrid`（默认 `hybrid`）

### A：用户只写本章大致规划

1. 填写 `plot/chapter-plan.md` 或对话给出要点（3–10 条即可）
2. 读 L0–L3 + 规划 + 人物/关系
3. 生成章节文件，**≥ 2000 汉字**
4. 章后：更新全部状态 + `state/next-chapter.md` + **在对话列出下一章选项**

### B：Agent 初稿 → 用户手改 → 同步

用户改 `chapters/` 后说「同步 003」→ 以磁盘正文为准回写记忆。改动大时可再「重新生成记忆」。

### C：重算记忆

按章号顺序读 `chapters/` 合法文件，重写 `plot/digest.md`、`state/short-term.md`（滚窗）、`state/continuity.md`，并校正人物、关系、`tasks`。**不改**章节正文。

---

## 章末：下一章建议（A / B / C 完成后）

更新 `state/next-chapter.md`，并在**对话**中输出：

```markdown
## 第 004 章可以写什么？

**A.** …
**B.** …
**C.** …
**自定义.** 请说明你的章规划
```

用户选定后写入 `plot/chapter-plan.md`，再执行模式 A。

---

## 目录结构

```
novel/
├── meta.yaml
├── README.md
├── background/
│   ├── _index.md
│   ├── core.md              # L0 根本（locked）
│   └── imports/
├── plot/
│   ├── outline.md
│   ├── chapter-plan.md      # 当前章粗略规划
│   ├── digest.md            # L1 精简剧情
│   ├── arcs.md
│   └── tasks.md
├── characters/
├── relationships.md
├── state/
│   ├── continuity.md        # L3
│   ├── short-term.md        # L2（节标题 ## 003）
│   └── next-chapter.md
└── chapters/
    └── 001序幕.md
```

Skill 模板：`skills/novel-writing/templates/` · 初始化：`scripts/init-novel.ps1`

---

## 记忆分层

| 层级 | 文件 | 说明 |
|------|------|------|
| L0 | `background/core.md` | locked；仅用户「修订根本设定」可改 |
| L1 | `plot/digest.md` | 全书已发生事（≤约 800 字） |
| L2 | `state/short-term.md` | 最近 N 章要点（`## 003`） |
| L3 | `state/continuity.md` | 当前快照 |
| 背景 | `background/*` | 见 `_index.md` |

优先级：`core` > canon 背景 > `digest` > `short-term` > `continuity` > 正文。

滚窗：章 M 出窗前，要点并入 `digest`，再删 `short-term` 中 `## MMM`。

---

## 写章 / 同步前加载顺序

1. `meta.yaml`、`README.md`
2. L0 → L1 → L2 → L3
3. `plot/chapter-plan.md`（模式 A）
4. `background/_index.md` → 相关 canon 背景
5. `outline.md`、`tasks.md`、`relationships.md`、出场人物卡
6. 必要时：上一章正文（章号最大者）

---

## 背景资料

- 新增 `.md` / `.txt` 须登记 `background/_index.md`
- `canon: false` 的 imports 不得当硬设定写入正文
- 静态设定放 `background/`；随剧情变的放 `continuity`

---

## 章后检查清单

- [ ] 文件名 `三位数字+文字.md|txt`
- [ ] 正文 ≥ `min_chars_per_chapter`
- [ ] `digest`、`short-term`（滚窗）、`continuity` 已更新
- [ ] 人物、关系、`tasks` 一致
- [ ] `next-chapter.md` 已写且**已在对话提示** A/B/C
- [ ] 未违反 `core.md`

---

## 章节元数据

**.md** frontmatter：`chapter`, `title`, `pov`, `status`（draft|final）, `author`（agent|human）, `char_count`

**.txt**：同名 `003标题-meta.yaml` 或记在 `short-term` / `continuity`

---

## 资源

- [reference.md](reference.md) · [install.md](install.md) · [templates/](templates/)
