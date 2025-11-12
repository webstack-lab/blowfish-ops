# 🚀 GSS Pipeline: Hugo + Blowfish + GitHub Pages

This repository is a [![**ready-to-use template**](https://img.shields.io/badge/Use_this_template-2ea44f?style=for-the-badge&logo=github)](https://github.com/webstack-lab/blowfish-ops/generate) for creating a static site using [Hugo](https://gohugo.io/) and the [Blowfish](https://blowfish.page/) theme, automatically deployed via **GitHub Pages**.


---

## 🧪 Steps to Create a New Blog

### 1. 📄 Create a New Repository Using This Template

* Click the **“Use this template”** button (top-right on GitHub)
* Choose a **repository name** (example: `my-blog`)
* Make sure it is **public**
* Confirm

---

### 2. ⚙️ Enable GitHub Pages (via Actions)

* Go to `Settings` → `Pages`
* Under **Build and Deployment**, select:

  * Source: **GitHub Actions**
* That’s it — GitHub Pages will wait for the workflow to build your site.

---

### 3. 🛠️ Edit `hugo.toml`

Before running or deploying locally, update your `hugo.toml`:

```toml
baseURL = 'https://<your-user>.github.io/<your-repo>/'
languageCode = 'en-us'
title = 'My Blog'
theme = 'blowfish'

[params]
  defaultTheme = "auto"
  ShowReadingTime = true
  ShowPostNavLinks = true
```
