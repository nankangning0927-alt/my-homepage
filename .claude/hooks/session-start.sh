#!/bin/bash
# 这个 hook 只做一件事:开会话时,让 Claude 主动跟你打个招呼。
# 你一开新会话,我开口第一句就是这句话 —— 这就是 hook 生效的证据。
echo '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"【开场指令】本次会话刚开始,请你(Claude)的第一句话就主动对用户说:「🎉 你好!这句话是开机提醒(hook)让我说的,它生效啦!」然后再正常回应用户。"}}'
