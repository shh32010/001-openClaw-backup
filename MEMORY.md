# MEMORY.md — 001 的长期记忆

> 从日记中提炼的精华，值得跨会话记住的东西。

---

## 👤 关于浩哥（宝宝）

- 喜欢温暖 + 搞怪的风格，叫我「宝宝 😘」
- 扬州邗江区
- 有两台设备：001 台式机（家里）、002 笔记本（宿舍）
- 偏好精简配置，不喜欢冗余的东西
- 通过 SSH 隧道访问 001 台式机：`ssh -N -L 18790:127.0.0.1:18789 001@10.6.22.1`

## 🖥️ 设备与网络

- **001 台式机**：家里，Windows 10，IP `10.6.22.1`，运行 OpenClaw Gateway
- **002 笔记本**：宿舍，也装了 OpenClaw
- Gateway 端口：`18789`，bind `lan`
- 微信插件已接入，openId: `o9cq802qe2q3Uu-3Vb8lBrCjI1Lk@im.wechat`
- Git 备份仓库：`git@github.com:shh32010/001-openClaw-backup.git`，每天凌晨 3 点自动备份

## 🤖 模型配置

- 主模型：小米 `mimo-v2.5-pro`（1M 上下文，32K 输出）
- 备选：NVIDIA `DeepSeek-V4-Pro` → GPT-Agent `Claude Sonnet 4.6`
- 思考模式默认 `high`
- 2026-05-09 更新了小米 API Key

## 🔧 重要经验

### 配置管理
- 不要用正则编辑 JSON，用精确文本替换或 Node.js 脚本
- 编辑 JSON 后必须验证：`node -e "JSON.parse(require('fs').readFileSync('file','utf8'))"`
- PowerShell 的 `ConvertFrom-Json` 有 BOM 兼容问题，验证 JSON 优先用 Node.js
- `controlUi` 配置会被网关自动播种（localhost + 127.0.0.1），删了也会回来
- Gateway restart --safe 有 defer 无 watchdog 的 bug，--force 更可靠

### 技能安装
- `openclaw skills install` 在 Windows 上有 EPERM 权限问题
- 用 `clawhub` 安装更可靠
- 微信插件 CLI 报错 ≠ 实际不工作，实际收发正常

### 微信相关
- Cron 问候任务需要 `delivery.to` 设为微信 openId
- timeout 至少 200s，lightContext: true
- 第一次测试缺 delivery target，第二次 120s 超时，第三次才成功

## 📅 定时任务

- 早安 8:00 + 天气
- 午安 12:00
- 晚安 21:00
- 凌晨 3:00 Git 备份

## 🎯 待办

- [ ] 002 号笔记本的 OpenClaw 配置同步
- [ ] 养成修完问题立即记录的习惯（self-improvement）

---

*最后更新：2026-05-09*
