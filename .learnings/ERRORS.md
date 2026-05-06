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
