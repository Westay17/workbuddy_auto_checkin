#!/bin/zsh
# add_account.sh —— 多账号 token 导出（本机一次性操作）
#
# 用法：
#   1. 在 WorkBuddy 客户端里退出当前账号，登录第 N 个账号
#   2. 运行:  ./add_account.sh N     （N = 2 或 3 …）
#   3. 导出成功后，切换回你想常驻的账号
#
# 导出的 token 写入 GitHub Secret WB_ACCESS_TOKEN_N（约 28 天有效）。
set -e
N="${1:?用法: ./add_account.sh <账号序号>，例如 2 或 3}"
REPO="Westay17/workbuddy_auto_checkin"

cd "$(dirname "$0")"

WORKBUDDY_EXE="/Applications/WorkBuddy.app/Contents/MacOS/Electron" \
WORKBUDDY_AUTH_FILE="$HOME/Library/Application Support/CodeBuddyExtension/Data/Public/auth/workbuddy-desktop.info" \
GH_TOKEN="$(cat "$HOME/.workbuddy/gh_oauth_token")" \
PATH="$HOME/.local/bin:$PATH" \
python3 refresh_token.py --gh-repo "$REPO" --secret-name "WB_ACCESS_TOKEN_$N"

echo ""
echo "✅ 账号 $N 已写入 Secret WB_ACCESS_TOKEN_$N（仓库 $REPO）"
echo "   下一步：在 WorkBuddy 切换到下一个账号继续 ./add_account.sh 下一序号，或切回主账号。"
