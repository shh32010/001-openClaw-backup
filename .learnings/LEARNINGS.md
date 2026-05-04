
## [LRN-20260504-003] best_practice — Markdown 表格对齐正确写法

**Logged**: 2026-05-04T14:02:00Z
**Priority**: high
**Status**: pending
**Area**: docs

### Summary
Markdown 表格对齐，不能只在第一行（表头分隔行）加宽度，必须让每个单元格的文字内容向右填充到与分隔线宽度一致，VSCode 才能正确渲染。

### Wrong way
`markdown
| 技能 | 版本 | 说明 |
|------|------|---------------------------------------------------------------|
| agent-browser-core | 1.0.1 | 浏览器远程控制 |
`
只在分隔线加宽度，内容列不对齐 → VSCode 渲染歪

### Correct way
`markdown
| 技能 | 版本 | 说明 |
|:----------------------|:------|:---------------------------------------------------------------|
| agent-browser-core    | 1.0.1 | 浏览器远程控制（agent-browser CLI） |
| office-editor         | 1.0.1 | Word/Excel/PowerPoint 文件创建与编辑 |
`
每个单元格内容向右填充空格，让列宽与分隔线一致

### Key insight
Markdown 表格对齐的核心是：**每行每个单元格的文字内容必须填充到与分隔线（separator）相同的宽度**，VSCode/monospace 渲染器才能正确显示。不是只在分隔行写宽度，是每一行的每个单元格都要对齐分隔线的宽度。

### Metadata
- Source: user_feedback
- Tags: markdown, table-alignment, vscode, docs
- Pattern-Key: markdown.table_alignment
- Related: LRN-20260504-001

---
## [LRN-20260504-004] knowledge_gap — Control UI /new 只能开新标签，不能清空当前上下文

**Logged**: 2026-05-04T14:23:00Z
**Priority**: low
**Status**: pending
**Area**: config

### Summary
用户希望开新对话时清空当前会话上下文，但不换标签。OpenClaw Control UI 的 /new 行为是打开新标签页，无法配置为"清空当前标签"。

### Details
- openclaw config get/set 没有 new-conversation 行为的配置项
- /new 或 Control UI 的新对话按钮 → 永远是开新标签
- 无法在当前标签清空上下文

### Suggested Action
记录为已知限制，后续如果需要可以考虑给 OpenClaw 提 feature request

### Metadata
- Source: user_request
- Tags: openclaw, control-ui, session, limitation
- Pattern-Key: openclaw.new_tab_behavior