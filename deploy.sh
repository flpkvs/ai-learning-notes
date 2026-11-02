#!/usr/bin/env bash
# 一键把本项目推送到你的 GitHub 个人仓库（留档）
# 用法：
#   1) 在 GitHub 生成 token 并「复制」到剪贴板
#   2) 在项目目录下执行  bash deploy.sh
set -e

REPO_NAME="ai-learning-notes"

echo "=================================================="
echo "  把我的「AI 学习笔记」网站推送到 GitHub 个人仓库"
echo "=================================================="
echo ""

# 1. 获取 token：优先读剪贴板，否则提示粘贴
TOKEN=""
if command -v pbpaste >/dev/null 2>&1; then
  CLIP="$(pbpaste 2>/dev/null | tr -d '[:space:]')"
  case "$CLIP" in
    ghp_*|github_pat_*) TOKEN="$CLIP" ;;
  esac
fi

if [ -z "$TOKEN" ]; then
  echo "没在剪贴板里找到 token。请把刚刚复制的那串 token 粘贴进来再回车："
  printf "Token: "
  read -rs TOKEN
  echo ""
fi

if [ -z "$TOKEN" ]; then
  echo "❌ 没有拿到 token，退出。"
  exit 1
fi

# 2. 验证 token，顺便拿到用户名
echo "正在验证 token ..."
USER_JSON=$(curl -s -H "Authorization: token $TOKEN" https://api.github.com/user)
LOGIN=$(printf '%s' "$USER_JSON" | python3 -c "import sys,json;print(json.load(sys.stdin).get('login',''))" 2>/dev/null || true)
if [ -z "$LOGIN" ]; then
  echo "❌ token 无效或已失效（可能没勾选 repo 权限，或已过期/作废）。"
  echo "   请重新到 https://github.com/settings/tokens 生成一个勾选 repo 的 token，复制后再运行本脚本。"
  exit 1
fi
echo "   ✅ 已识别账号：$LOGIN"

# 3. 创建仓库（已存在会返回 422，视为成功）
echo ""
echo "正在创建仓库 $REPO_NAME ..."
HTTP=$(curl -s -o /tmp/gh_resp.json -w "%{http_code}" \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"我的 AI 学习笔记个人主页\",\"public\":true}")

if [ "$HTTP" = "201" ] || [ "$HTTP" = "422" ]; then
  echo "   ✅ 仓库就绪"
else
  echo "   ❌ 创建失败 (HTTP $HTTP)，返回内容："
  cat /tmp/gh_resp.json
  exit 1
fi

# 4. 推送
echo ""
echo "正在推送代码到 GitHub ..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://${LOGIN}:${TOKEN}@github.com/${LOGIN}/${REPO_NAME}.git"
git push -u origin main

echo ""
echo "=================================================="
echo "  ✅ 完成！访问：https://github.com/${LOGIN}/${REPO_NAME}"
echo "=================================================="
echo "💡 安全提示：用完请到 https://github.com/settings/tokens 撤销这个 token"
echo "💡 想让网站在线可访问，可在仓库 Settings → Pages 开启 GitHub Pages"
