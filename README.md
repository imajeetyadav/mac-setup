# Mac Setup

Automated Mac setup for Apple Silicon (M-series) machines. Run once on a fresh Mac or re-run anytime to sync new tools.

---

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/imajeetyadav/mac-setup.git ~/Projects/mac-setup
cd ~/Projects/mac-setup

# 2. Run the setup script
bash quick-mac-setup.sh
```

The script is idempotent — safe to re-run on an existing machine.

---

## What Gets Installed

### Prerequisites (auto-handled)
- **Xcode Command Line Tools** — required by Homebrew and many packages
- **Homebrew** — package manager for macOS

### Shell
| Tool | Description |
|------|-------------|
| Oh My Zsh | Zsh framework |
| Powerlevel10k | Fast, customizable prompt |
| zsh-autosuggestions | Fish-like command suggestions |
| zsh-completions | Additional completions |
| zsh-history-substring-search | History search with Up/Down |
| fast-syntax-highlighting | Syntax highlighting in terminal |
| alias-tips | Reminds you of existing aliases |
| zsh-you-should-use | Nudges you to use your aliases |

### Version Managers
| Tool | Installs |
|------|----------|
| NVM | Node.js LTS |
| SDKMAN | Java 21 (Temurin) |
| FVM | Flutter (stable) |
| tfenv | Terraform (latest) |

### CLI Tools (via Brewfile)

**Cloud & Infrastructure**
`awscli`, `azure-cli`, `doctl`, `gcloud-cli`, `eksctl`, `helm`, `helmfile`, `kustomize`, `kubectl`, `kubectx`, `k9s`, `argocd`, `flux`, `terraform-docs`, `terragrunt`, `tflint`, `tfsec`, `terrascan`, `tfenv`, `hcledit`, `vault`, `steampipe`, `komiser`, `inframap`, `localstack-cli`

**Security**
`grype`, `trivy`, `trufflehog`, `kubescape`, `checkov`, `prowler`, `cosign`, `sops`, `talisman`, `gnupg`

**Containers & Kubernetes**
`minikube`, `ko`, `skopeo`, `pack`, `popeye`, `kubeshark`, `kubespy`, `stern`, `kargo`, `krr`

**Development**
`git`, `gh`, `go`, `rust`, `python@3.12/3.13/3.14`, `node` (via NVM), `ruby`, `php`, `composer`, `uv`, `pipenv`, `pyenv`, `sdkman-cli`, `fastlane`, `cocoapods`, `ios-deploy`, `act`, `pre-commit`

**Databases**
`mongosh`, `mongodb-database-tools`, `redis`, `mysql-client`, `pgcli`, `libpq`, `msodbcsql18`, `mssql-tools18`

**Utilities**
`bat`, `fzf`, `jq`, `yq`, `ripgrep`, `wget`, `watch`, `tree`, `lnav`, `goaccess`, `httpie`, `nmap`, `netcat`, `k6`, `imagemagick`, `ffmpeg`, `graphviz`

### Applications (via Brewfile)
`iterm2`, `visual-studio-code`, `jetbrains-toolbox`, `github`, `postman`, `bruno`, `brave-browser`, `slack`, `notion`, `zoom`, `microsoft-teams`, `docker` (via Docker Desktop), `mysqlworkbench`, `stats`, `appcleaner`, `betterdisplay`, `canva`, `vlc`, `ngrok`, `openvpn-connect`, `miniforge`, `comfyui`, `claude-code`, `bootstrap-studio`

### Applications (via direct DMG install)
| App | Source |
|-----|--------|
| UTM | GitHub releases (`utmapp/UTM`) — QEMU-based VM runner for Apple Silicon |
| Podscape | GitHub releases (`codingprotocols/podscape`) |

### VS Code Extensions
Includes extensions for: Python, Go, Java, Flutter/Dart, JavaScript/TypeScript, Kubernetes, Terraform, Azure, AWS, Docker, GitHub Copilot, databases, and more. See `Brewfile` for the full list.

---

## Manual Steps

### Restore Zsh config
Copy `zshrc` from this repo to `~/.zshrc`:
```bash
cp zshrc ~/.zshrc
source ~/.zshrc
```

### App Switcher on all displays
```bash
defaults write com.apple.dock appswitcher-all-displays -bool true
killall Dock
```

---

## Files

| File | Purpose |
|------|---------|
| `quick-mac-setup.sh` | Main setup script |
| `Brewfile` | All Homebrew packages, casks, and VS Code extensions |
| `zshrc` | Zsh configuration |
| `update-commands.txt` | Useful commands for keeping tools up to date |
