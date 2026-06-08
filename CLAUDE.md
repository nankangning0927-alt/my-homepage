# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

一个极简的**个人主页**,整站就是单个静态文件 `index.html`(HTML + 内联 `<style>`,无 JavaScript、无构建步骤、无依赖)。内容为中文(`lang="zh-CN"`)。

## 架构

- **`index.html`** —— 整个网站。所有 CSS 写在 `<head>` 的 `<style>` 里,靠 `:root` 中的 CSS 变量(`--bg`、`--text`、`--accent`、`--max` 等)统一控制配色与布局;`@media (max-width: 720px)` 负责手机端响应式。页面分三个区块,用 `id` 锚点串联导航:
  - `#home`(`.hero`):大标题 + 自我介绍 + 行动按钮
  - `#work`:作品区,卡片放在 `<div class="grid">` 里,每张是一个 `<article class="card">`
  - `#contact`:联系方式
- 改样式 = 优先改 `:root` 里的变量;改内容 = 直接改对应区块的文字。新增作品卡片务必沿用现有 `<article class="card">` 的结构与缩进,否则样式会错乱。

## 预览与部署

- **本地预览**:用浏览器直接打开 `index.html` 即可(纯静态,无需服务器)。
- **线上部署**:GitHub Pages,**从 `main` 分支根目录**发布,地址为 `https://nankangning0927-alt.github.io/my-homepage/`。`main` 一更新,线上几分钟后自动刷新。
- **发布流程**:在功能分支上开发,确认无误后快进合并到 `main`(`git push origin <feature-branch>:main`)来更新线上站点。

## 自定义 Skill

`.claude/skills/add-work/` 定义了项目级 Skill `/add-work`:在作品区追加一张项目卡片。其规则(只动作品区、卡片结构需与现有一致)同样是改这个文件时应遵守的约定。
