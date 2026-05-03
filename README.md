# 001 的 OpenClaw 工作区备份

宝宝的 AI 助手（OpenClaw）工作区自动备份仓库。

每次备份会自动生成压缩包并推送到 GitHub，确保工作区数据安全不丢失。

## 备份内容

| 类别 | 说明 |
|------|------|
| 配置文件 | openclaw.json 等核心配置 |
| 身份与设定 | SOUL.md（人格）、IDENTITY.md（身份）、USER.md（用户信息） |
| 工作区规范 | AGENTS.md（工作规范）、TOOLS.md（工具笔记）、HEARTBEAT.md（心跳任务） |
| 记忆文件 | memory/ 目录下的日常记录与长期记忆 |
| 技能（Skills） | workspace/skills 目录下所有已安装的 OpenClaw 技能 |

**已排除**：completions/ 缓存、plugin-runtime-deps/（npm 依赖，可再生）、日志文件。

## 设备信息

| 设备 | 位置 | 说明 |
|------|------|------|
| 001号台式机 | 家里 | 当前运行的主设备 |
| 002号笔记本 | 宿舍 | 备用设备 |

## 当前模型配置

| 角色 | Provider | 模型 | 状态 |
|------|---------|------|------|
| 主模型 | xiaomi-coding | mimo-v2.5-pro | ✅ 正常 |
| 备用模型 | gpt-agent.cc | claude-sonnet-4-6 | ✅ 已配置 |

## 定时任务

| 任务名 | 时间 | 模型 | 状态 | 说明 |
|--------|------|------|------|------|
| 每日备份 | 每天 03:00 | mimo-v2.5-pro | ✅ 正常 | 打包备份并推送到 GitHub |

## 技能清单

### workspace 安装技能（9个）

| 技能 | 功能 |
|------|------|
| agent-browser-core | AI友好型Web自动化，Rust+Playwright |
| office-editor | Word/Excel/PowerPoint 创建编辑 |
| office-document-editor | 专业文档编辑，修订标记/Git版本控制 |
| office-toolkit | Office+PDF 综合工具包 |
| openclaw-backup | 备份恢复 OpenClaw 数据 |
| self-improving-agent | 持续改进，捕获错误和纠正经验 |
| skill-vetter | 技能安全审查，安装前风险评估 |
| skillhub-preference | 优先使用 skillhub 安装技能 |
| sonoscli | Sonos 音箱控制 |

### 全局技能（52个）

涵盖：开发/Git、笔记文档、消息平台、Google云、搜索工具、音乐音频、语音TTS、邮件通讯、视频媒体、智能家居、系统工具等分类。

详见桌面文件：`D:\001\桌面\OpenClaw_Skills_Tools.md`

## 恢复步骤

```powershell
# 1. 停止 Gateway
openclaw gateway stop

# 2. 备份当前目录
Rename-Item ~/.openclaw ~/.openclaw-old

# 3. 拉取最新备份
git clone git@github.com:shh32010/001-openClaw-backup.git ~/.openclaw

# 4. 重启 Gateway
openclaw gateway start
```

## Git 信息

- 用户名：shh32010
- 仓库：git@github.com:shh32010/001-openClaw-backup.git
- 默认分支：master

---

*由 001 整理 😘*
