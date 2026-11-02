# 🤖 AI 学习笔记 · 个人主页

> 我的第一份开源作品：一个用「Agent 辅助」完成、记录 AI 学习心得与个人主页的静态网站。

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Made with ❤️](https://img.shields.io/badge/made%20with-%E2%9D%A4%EF%B8%8F-red.svg)](https://github.com/flpkvs)

## ✨ 关于本项目

这是一个**纯静态网站**，既是我的个人主页，也是我的 AI 学习笔记仓库。它是在
Agent 的辅助下，走完「想主题 → 写内容 → 建仓库 → commit/push → 发起 PR」完整
开源协作闭环的产物。

## 🚀 功能特性

- 🎨 响应式设计，适配桌面端与移动端
- 🌙 亮色 / 暗色主题切换（跟随系统偏好，可手动切换并记忆）
- 📚 3 篇 AI 学习笔记（LLM 基础 / 机器学习入门 / AI 辅助编程工具）
- ⚡ 零依赖、零构建，纯 HTML + CSS + JS，可直接部署到 GitHub Pages

## 📂 目录结构

```
ai-learning-notes/
├── index.html          # 主页（关于我 + 笔记列表 + 联系）
├── styles.css          # 全局样式（含主题变量与暗色模式）
├── script.js           # 主题切换逻辑
├── notes/
│   ├── llm-basics.html              # 大语言模型（LLM）基础
│   ├── machine-learning-intro.html  # 机器学习入门
│   └── ai-tools.html                # AI 辅助编程工具
├── LICENSE             # MIT 协议
└── README.md           # 本文件
```

## 🛠 本地预览

这是一个纯静态站点，直接用任意静态服务器打开即可：

```bash
# 方式一：Python 内置服务器
python3 -m http.server 8000

# 方式二：直接双击 index.html（部分浏览器即可打开）
```

然后访问 <http://localhost:8000> 查看效果。

## 🌐 部署到 GitHub Pages

1. 在仓库 `Settings → Pages` 中选择分支 `main`、目录 `/ (root)`；
2. 保存后稍等片刻，即可通过 `https://<用户名>.github.io/ai-learning-notes/` 访问。

## 🤝 如何贡献

欢迎通过 Issue 或 Pull Request 参与：

- 发现笔记有错误、表述不清，请提 Issue；
- 想补充新的学习笔记，请发起 PR，并在 PR 说明中描述你的改动。

## 📄 许可

本项目使用 [MIT License](LICENSE) 开源。
