#!/bin/bash
# ============================================================
#  SessionStart Hook —— 每次"开新会话"时自动运行的脚本
# ============================================================
#  作用:开会话时
#    ① 给【你(用户)】弹一条部署提醒(systemMessage)
#    ② 给【Claude(我)】悄悄塞入项目背景(additionalContext)
#
#  怎么生效:这个脚本只需要做一件事 —— 往“标准输出”打印一段 JSON。
#  Claude Code 读到这段 JSON,就会按字段各取所需。
# ============================================================

set -euo pipefail   # 严格模式:出错即停、未定义变量报错、管道出错也算失败

# ------------------------------------------------------------
#  ★【看得见的脚印】每次开会话,往日志文件追加一行带时间的记录。
#    手机上看不到 systemMessage 弹窗没关系 —— 这个文件会一直在,
#    随时打开就能看到 hook 跑过几次、分别是什么时候。
#  注意:这里写的是“文件”,不是“标准输出”,所以不会干扰下面那段 JSON。
# ------------------------------------------------------------
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"   # 算出项目根目录
echo "🐾 开会话 - $(date '+%Y-%m-%d %H:%M:%S')" >> "$DIR/.claude/session-log.txt"

# --- 把要提醒你的话写成变量,方便日后修改 ---
MSG="📢 部署提醒:本站经 GitHub Pages 从 main 分支发布。请在功能分支开发,确认无误后快进合并到 main(git push origin <feature-branch>:main)更新线上。"

# --- 把要喂给 Claude 的项目背景也写成变量 ---
CONTEXT="本项目部署方式:GitHub Pages 从 main 分支根目录发布;开发流程是功能分支开发后快进合并到 main。"

# --- 打印 JSON。两个字段分别给不同对象用: ---
#   systemMessage           → 显示给【你】看(终端里会单独弹出)
#   hookSpecificOutput.additionalContext → 悄悄注入给【Claude】的上下文
cat <<EOF
{
  "systemMessage": "${MSG}",
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${CONTEXT}"
  }
}
EOF
