# Errors

---

## 网关重启后无法自动拉起（Windows）

**日期：** 2026-05-06
**环境：** Windows 10 / OpenClaw 2026.5.4

### 问题描述
每次修改配置后执行 `openclaw gateway restart`，网关进程被杀后，计划任务（schtasks）没有自动把它拉起来。原因是：

1. `openclaw gateway restart --safe` 会触发"热重载 defer"机制，等待活跃任务完成
2. 但 OpenClaw 的 defer 没有 watchdog——任务完成后**不会触发后续的重启**
3. 结果：网关停止，没有自动重启，需要手动运行 `gateway.cmd` 或重启用户 session

### 临时方案
- 使用 `openclaw gateway restart --force`（强制杀掉重启）——但schtasks拉起也不稳定
- 手动运行：`& "C:\Users\001\.openclaw\gateway.cmd"`

### 根本原因
OpenClaw 的 gateway reload defer 机制缺少 watchdog 逻辑，重启被 defer 后没有后续触发。这是 OpenClaw 本身的 bug，不是配置问题。

### 相关日志
```
config change requires channel reload (openclaw-weixin) — deferring until 2 operation(s), 1 reply(ies), 1 active embedded run(s)
```

---

## 正则删除 JSON 配置块导致文件损坏

**日期：** 2026-05-09
**环境：** Windows 10 / OpenClaw 2026.5.7

### 问题描述
用 PowerShell 正则删除 openclaw.json 中的 `controlUi` 配置块时，正则过于宽泛，把 gateway 对象的闭合 `}` 也一并删掉了，导致整个 JSON 文件损坏。

```powershell
# 错误的正则
$content -replace '(?m)^\s*"controlUi":\s*\{[^}]*\}[^}]*\},?\r?\n?', ''
```

`[^}]*\}[^}]*\}` 匹配到了超出预期的范围，吞掉了 gateway 的闭合括号。

### 修复
手动补回 gateway 的 `}` 并修正缩进，用 Node.js 验证 JSON 合法性。

### 教训
1. **不要用正则编辑 JSON** — 用 `edit` 工具做精确文本替换，或者用 `node` 脚本读取→修改→写回
2. **编辑 JSON 后必须验证** — `node -e "JSON.parse(require('fs').readFileSync('file','utf8'))"`
3. **PowerShell 的 `ConvertFrom-Json` 有 BOM 兼容问题** — 验证 JSON 优先用 Node.js
