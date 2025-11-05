# Automation Scripts – Hugo + Blowfish Ops

This folder contains a set of Shell scripts designed to speed up the creation, configuration, and deployment of a Hugo site using the Blowfish theme.  
They are intended to simplify workflows for **multi-language**, **multi-author**, and **GitHub Pages–hosted** websites.

---

## Available Scripts

| Script                      | Main purpose |
|----------------------------|--------------|
| `setup-multilang.sh`       | Initializes multiple languages in `hugo.toml` and creates the required folders under `content/`. |
| `generate-lang-content.sh` | Automatically generates base files (e.g., `welcome.md`) for each language. |
| `set-language.sh`          | Adds or removes a language from the configuration. |
| `set-meta.sh`              | Updates site metadata (description, slogan, bio…). |
| `generate-images.sh`       | *(Work in progress)* Prepares a system for image generation/organization. |

---

## Requirements

- Hugo **Extended** installed (`hugo version`)  
- A Hugo project initialized with Blowfish  
- Scripts must be executable if needed:
  `chmod +x scripts/*.sh`

## Basic Usage

```bash
# Initialize multiple languages
./setup-multilang.sh en fr es

# Generate base content for each language
./generate-lang-content.sh

# Update metadata
./set-meta.sh --description "Multilingual blog" --slogan "Create. Share."
```

---

## TODO (planned improvements)

* Adapt `sed -i` commands for Linux + macOS compatibility
* Add a `--dry-run` mode
* Add a verbose mode and logging system
* Check dependencies (Hugo, Git, paths) before running
* Improve image handling (dimension presets, WebP, retina)
* Add a full project initialization script
* Provide a ready-to-use GitHub Actions workflow
* Add Windows support (WSL or PowerShell)
* Test scripts with `shellcheck` or simple CI pipelines

---

## Open Questions

* Do you prefer modular scripts, or a single unified script (`blowfish-ops init`)?
* Any recommendations for git-based CMS (Decap, CloudCannon, TinaCMS…) to integrate?
* What should be automated first (menus, SEO, authors, images, multilingual setup…)?
* Would you be interested in turning this into an **open-source CLI** for Hugo + Blowfish + GitHub Pages?

---

Feel free to suggest improvements or open a Pull Request.
