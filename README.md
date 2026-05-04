# 001 的 OpenClaw 工作区

> 宝宝的 AI 助手 001 —— 温暖贴心，随叫随到。

这是一个 [OpenClaw](https://docs.openclaw.ai) 工作区的完整备份仓库，包含所有配置、技能、记忆和定时任务。

---

## 目录

- [关于 001](#关于-001)
- [设备信息](#设备信息)
- [模型配置](#模型配置)
- [已安装技能](#已安装技能)
- [定时任务](#定时任务)
- [微信插件](#微信插件)
- [工作区文件说明](#工作区文件说明)
- [备份与恢复](#备份与恢复)
- [Git 信息](#git-信息)

---

## 关于 001

| 属性 | 值 |
|:-----|:---|
| 名字 | 001 |
| 定位 | AI 助手 |
| 风格 | 温暖 + 搞怪，陪你聊天也陪你犯傻 |
| Emoji | _(默认)_ |
| 主人 | 浩哥（宝宝） |
| 时区 | Asia/Shanghai (GMT+8) |

---

## 设备信息

| 设备       | 类型   | 位置   | 说明 |
|:-----------|:-------|:-------|:-----|
| 001号台式机 | 主设备 | 家里   | 当前运行 OpenClaw Gateway |
| 002号笔记本 | 备用   | 宿舍   | 已安装 OpenClaw |

两台设备共享同一个 GitHub 仓库，方便在不同环境恢复工作区。

---

## 模型配置

| 角色       | Provider       | 模型                | 状态 |
|:-----------|:---------------|:--------------------|:-----|
| 主模型     | gpt-agent      | claude-sonnet-4-6   | ✅ 正常 |
| 备用模型   | xiaomi-coding  | mimo-v2.5-pro       | ✅ 已配置 |

### Provider 配置

- **gpt-agent** — 主力 Provider，使用 API Key 配置在 `models.json`
- **xiaomi-coding** — 备用 Provider，通过 `models.json` 中的 API Key 连接
- **openrouter** — 已配置但暂未使用

---

## 已安装技能

### 工作区技能（workspace，9个）

这些技能直接安装在 `workspace/skills/` 目录下，可以随仓库一起备份和恢复。

| 技能                   | 版本  | 说明 |
|:-----------------------|:------|:-----|
| agent-browser-core     | 1.0.1 | AI 友好型 Web 自动化，基于 Rust + Playwright |
| office-editor          | 1.0.1 | Word/Excel/PowerPoint 文件创建与编辑 |
| office-document-editor | 1.0.0 | 专业 Word 编辑（修订模式、Git 版本控制） |
| office-toolkit         | 1.0.1 | Office + PDF 综合工具包（读写、格式转换、批量处理） |
| openclaw-backup        | 1.0.0 | 备份与恢复 OpenClaw 数据，支持远程推送到 GitHub |
| self-improving-agent   | -     | 持续改进 Agent（捕获错误、纠正经验）+ 自改进 Hook |
| skill-vetter           | 1.0.0 | 安全审查技能，安装前风险评估 |
| skillhub-preference    | -     | 优先使用 skillhub 发现与安装技能 |
| sonoscli               | -     | Sonos 音箱控制 |

### 全局技能（eligible，已就绪）

这些是 OpenClaw 内置的全局技能，当前环境已满足依赖条件。

| 技能               | 所需依赖     | 功能说明 |
|:-------------------|:-------------|:---------|
| browser-automation | 浏览器       | 多步流程、登录检查、标签管理 |
| clawhub            | -            | 搜索、安装、更新技能 |
| coding-agent       | -            | 代码任务代理（Codex/Claude Code/Pi） |
| github             | gh ✅        | GitHub 仓库、Issue、PR 管理 |
| gh-issues          | gh ✅        | GitHub Issue 委托修复、打开 PR |
| healthcheck        | -            | 主机安全审计（SSH、防火墙、更新） |
| node-connect       | -            | OpenClaw Android/iOS/macOS 配对诊断 |
| sag                | -            | ElevenLabs TTS 语音合成 |
| session-logs       | jq ✅        | 查看与分析 OpenClaw 会话日志 |
| skill-creator      | -            | 创建、编辑、审计 AgentSkill |
| taskflow           | -            | 多步任务协调（TaskFlow job） |
| taskflow-inbox-triage | -         | 收件箱分类、意图路由、等待回复 |
| video-frames       | ffmpeg ❌    | 视频帧提取、缩略图/GIF 生成 |
| weather            | curl ✅      | 天气查询（wttr.in） |

### 全局技能（需安装 CLI）

| 技能               | 所需 CLI     | 安装命令                       | 功能说明 |
|:-------------------|:-------------|:-------------------------------|:---------|
| 1password          | op           | `winget install 1Password.CLI` | 1Password 密码管理 |
| blogwatcher        | blogwatcher  | `cargo install blogwatcher`    | 监控博客和 RSS 源 |
| discord            | -            | 需 Discord Bot Token           | 发送 Discord 消息 |
| gifgrep            | gifgrep      | `cargo install gifgrep`        | 搜索 GIF 动图 |
| gog                | gog-cli      | `cargo install gog_cli`        | GOG 游戏平台管理 |
| goplaces           | goplaces     | `cargo install goplaces`       | Google Places 查询 |
| himalaya           | himalaya     | `cargo install himalaya`       | 命令行邮件客户端 |
| mcporter           | mcporter     | `cargo install mcporter`       | Minecraft 数据导出 |
| notion             | -            | 需 Notion API Key              | Notion 笔记读写 |
| obsidian           | -            | 需 Obsidian REST API           | Obsidian 笔记操作 |
| spotify-player     | spotify_player | `cargo install spotify_player` | Spotify 播放控制 |
| summarize          | -            | 内置                           | 网页/文档摘要 |
| trello             | -            | 需 Trello API Key              | Trello 看板管理 |
| voice-call         | -            | 需 Twilio 等配置               | 语音通话 |
| wacli              | wacli        | 需安装                         | WhatsApp CLI |
| xurl               | -            | 需安装                         | URL 操作工具 |

---

## 定时任务

| 任务         | 时间     | 渠道   | 说明 |
|:-------------|:---------|:-------|:-----|
| 早安 + 天气  | 每天 08:00 | 微信  | 扬州天气 + 温暖问候 |
| 午安问候     | 每天 12:00 | 微信  | 轻松午间问候 |
| 晚安问候     | 每天 21:00 | 微信  | 暖心道晚安 |
| 每日备份     | 每天 03:00 | WebChat | 自动备份工作区到 GitHub |

所有问候任务均配置 `lightContext: true` + 200 秒超时，确保微信推送稳定。

---

## 微信插件

| 项目     | 值 |
|:---------|:---|
| 插件     | `@tencent-weixin/openclaw-weixin@2.4.1` |
| 状态     | ✅ 已安装，消息收发正常 |
| 微信 ID  | `170e470b7626-im-bot` |

### 已知问题

- `openclaw channels list` CLI 不显示微信 channel，但实际消息收发正常
- `openclaw channels login --channel openclaw-weixin` CLI 报错 "Unsupported channel"，但扫码登录后可以正常使用
- 这是 OpenClaw CLI 的显示问题，不影响实际功能

---

## 工作区文件说明

### 核心文件

| 文件           | 说明 |
|:---------------|:-----|
| `AGENTS.md`    | 工作规范 — 启动流程、记忆管理、群聊行为、心跳策略 |
| `SOUL.md`      | 人格定义 — 真诚、有主见、资源丰富、尊重隐私 |
| `IDENTITY.md`  | 身份信息 — 名字、定位、风格 |
| `USER.md`      | 用户信息 — 浩哥（宝宝）的偏好和设备 |
| `TOOLS.md`     | 工具笔记 — 本地环境特有的配置信息 |
| `HEARTBEAT.md` | 心跳任务 — 定期检查的待办事项 |
| `README.md`    | 本文件 — 工作区总览 |

### 记忆目录 (`memory/`)

| 文件/目录                     | 说明 |
|:------------------------------|:-----|
| `YYYY-MM-DD.md`              | 每日记录 — 当天发生的重要事件 |
| `heartbeat-state.json`      | 心跳状态 — 上次检查的时间戳 |
| `.dreams/`                   | 梦境系统 — 深层记忆处理 |
| `dreaming/deep/`             | 深度梦境 — 长期记忆整合 |
| `dreaming/light/`            | 轻度梦境 — 短期记忆整理 |
| `dreaming/rem/`              | REM 梦境 — 创造性联想 |

### 自改进系统 (`.learnings/`)

| 文件               | 说明 |
|:-------------------|:-----|
| `LEARNINGS.md`     | 经验教训 — 用户纠正、知识更新 |
| `ERRORS.md`        | 错误记录 — 命令失败、工具异常 |
| `FEATURE_REQUESTS.md` | 功能需求 — 用户期望但尚未实现的能力 |

### Hook 系统

| Hook               | 状态  | 说明 |
|:-------------------|:------|:-----|
| boot-md            | ✅    | 启动时加载 Markdown 文件 |
| bootstrap-extra-files | ✅ | 额外文件引导 |
| command-logger     | ✅    | 命令日志记录 |
| compaction-notifier | ✅   | 上下文压缩通知 |
| session-memory     | ✅    | 会话记忆保存 |
| self-improvement   | ✅    | 自改进 Hook |

---

## CLI 工具状态

| 工具       | 版本         | 用途         | 状态 |
|:-----------|:-------------|:-------------|:-----|
| gh         | 2.92.0       | GitHub CLI   | ✅ 已安装 |
| jq         | 1.8.1        | JSON 处理    | ✅ 已安装 |
| Python     | 3.14.0       | 脚本运行     | ✅ 已安装 |
| npm        | -            | 包管理       | ✅ 已安装 |
| curl       | 8.13.0       | HTTP 请求    | ✅ 已安装 |
| ffmpeg     | -            | 视频处理     | ❌ 未安装 |
| op         | -            | 1Password    | ❌ 未安装 |
| cargo      | -            | Rust 包管理  | ❌ 未安装 |

---

## 备份与恢复

### 自动备份

已配置每日凌晨 3:00 自动备份，通过 cron 任务触发。

### 手动备份

```powershell
# 方式 1：使用 OpenClaw 备份技能
openclaw cron trigger <备份任务ID>

# 方式 2：手动打包
$ts = Get-Date -Format "yyyy-MM-dd_HHmm"
$dst = "C:\Users\001\openclaw-backups\openclaw-$ts"
New-Item -ItemType Directory -Path $dst -Force
Copy-Item "C:\Users\001\.openclaw\openclaw.json" "$dst\"
Copy-Item "C:\Users\001\.openclaw\cron" "$dst\cron" -Recurse -Force
Copy-Item "C:\Users\001\.openclaw\workspace" "$dst\workspace" -Recurse -Force
```

### 恢复步骤

```powershell
# 1. 停止 Gateway
openclaw gateway stop

# 2. 备份当前目录（以防万一）
Rename-Item ~/.openclaw ~/.openclaw-old

# 3. 克隆仓库
git clone git@github.com:shh32010/001-openClaw-backup.git ~/.openclaw/workspace

# 4. 恢复配置文件
Copy-Item ~/.openclaw/workspace/openclaw.json ~/.openclaw/
Copy-Item ~/.openclaw/workspace/cron ~/.openclaw/cron -Recurse

# 5. 重启 Gateway
openclaw gateway start

# 6. 重新安装工作区技能
# OpenClaw 会自动从 skills/ 目录加载工作区技能
```

### 备份内容

| 类别 | 包含 | 排除 |
|:-----|:-----|:-----|
| 配置文件 | openclaw.json, models.json, auth-profiles.json | - |
| 身份设定 | SOUL.md, IDENTITY.md, USER.md | - |
| 工作规范 | AGENTS.md, TOOLS.md, HEARTBEAT.md | - |
| 记忆文件 | memory/*.md, memory/.dreams/ | *.log |
| 技能 | workspace/skills/ | node_modules/ |
| 定时任务 | cron/ | - |
| 学习记录 | .learnings/ | - |
| 缓存 | - | completions/, plugin-runtime-deps/ |

---

## Git 信息

| 项目     | 值 |
|:---------|:---|
| 用户名   | shh32010 |
| 仓库     | git@github.com:shh32010/001-openClaw-backup.git |
| 默认分支 | master |
| 远程     | origin (SSH) |

### 推送流程

```powershell
cd C:\Users\001\.openclaw\workspace
git add .
git commit -m "backup: 更新工作区 $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push origin master
```

---

## 快速开始（新设备）

```powershell
# 1. 安装 OpenClaw
npm install -g openclaw

# 2. 克隆工作区
git clone git@github.com:shh32010/001-openClaw-backup.git C:\Users\001\.openclaw\workspace

# 3. 复制配置文件
Copy-Item C:\Users\001\.openclaw\workspace\openclaw.json C:\Users\001\.openclaw\

# 4. 安装依赖
cd C:\Users\001\.openclaw\workspace
npm install

# 5. 启动 Gateway
openclaw gateway start

# 6. 访问控制面板
# 浏览器打开 http://127.0.0.1:18789
```

---

*由 001 整理 | 最后更新：2026-05-05*
