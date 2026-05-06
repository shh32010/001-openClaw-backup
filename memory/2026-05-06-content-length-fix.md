# Session: 2026-05-06 19:54:20 GMT+8

- **Session Key**: agent:main:main
- **Session ID**: 01b5bcdc-fa76-4048-9173-df2f7e25eb70
- **Source**: webchat

## Conversation Summary

assistant: **关键发现！** 问题确认是 `Content-Length` 头手动设置导致的。让我检查是不是 `forceResetGlobalDispatcher` 被调用了：

user: Sender (untrusted metadata):
```json
{
  "label": "openclaw-control-ui",
  "id": "openclaw-control-ui"
}
```

[Wed 2026-05-06 19:43 GMT+8] 怎么样了
assistant: **找到了！`forceResetGlobalDispatcher()` 导致手动 Content-Length 失败。**

解决方案：删除 `api.js` 里手动设置的 `Content-Length` 头（body 是字符串时会自动计算）。

assistant: 验证修复：

assistant: **两个问题都修复了！** 现在验证完整的登录流程：

assistant: **🎉 修复成功！** 两次测试都通过了。

## 问题总结

这次挖到了两层问题：

### 1. `package.json` 路径错误
`api.js` 里 `readPackageJson()` 查找 `dist/package.json`，但文件实际在插件根目录。找不到就静默返回空对象 `{}` → 导致：
- `iLink-App-Id: ""`（空）
- `iLink-App-ClientVersion: "0"`

### 2. `Content-Length` 头冲突
这是真正的 "fetch failed" 根因：
- OpenClaw gateway 启动时调用 `forceResetGlobalDispatcher()` → 全局 undici Agent 配置了 1800 秒超时
- `globalThis.fetch` 底层用这个 Agent 处理请求
- 插件 `buildHeaders()` 手动设置了 `Content-Length` 头
- undici Agent 在这个特定配置下对**手动设置的 Content-Length** 校验失败 → `invalid content-length header`

## 已修复

| 文件 | 修复 |
|------|------|
| `dist/package.json` | 复制了 `package.json` |
| `dist/src/api/api.js` | 删除了手动 `Content-Length` 头 |

现在试试：

```powershell
openclaw channels login --channel openclaw-weixin
```

如果想长期保持，可以把这两个修改固化到源码重新编译，或者装个本地 patch。但先试试看能否正常跑起来 🎯
user: [OpenClaw heartbeat poll]
assistant: HEARTBEAT_OK
user: [Wed 2026-05-06 19:49 GMT+8] 好像链接成功了，你测一下
assistant: 好，测一下！

assistant: 交互式命令，让我用 pty 模式：

assistant: 交互命令被安全策略阻止了。让我换个方式 — 直接在 gateway 进程环境里测试 API：

assistant: 有账号文件！看看状态：

assistant: 账号已经登录了！19:47:25 刚保存的 —— 正好是刚才。让我看看 gateway 日志里有没有 WeChat 相关的活跃记录：

assistant: 日志看清楚了！看看关键记录：

- **19:47:04** — 二维码获取成功 ✅
- **19:47:25** — 登录确认成功 ✅ `ilink_bot_id=c44d0e938301`
- **19:47:27** — 但 channel 启动失败（gateway 还没重启）

然后 gateway 检测到配置变化，等后台任务完成后准备重启。让我看最新状态：

