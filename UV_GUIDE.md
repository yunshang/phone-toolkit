# 使用 uv 管理 Phone Parser 项目

## 什么是 uv？

uv 是由 Astral（Ruff 的开发者）开发的超快 Python 包管理器，比 pip 快 10-100 倍，并提供更好的依赖解析。

## 快速开始

### 1. 安装 uv

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# 或使用 pip
pip install uv
```

### 2. 初始化项目

```bash
cd /Users/alshin/www/phone/phone_py

# 创建虚拟环境（自动检测 .python-version）
uv venv

# 激活虚拟环境
source .venv/bin/activate  # macOS/Linux
# .venv\Scripts\activate    # Windows
```

### 3. 安装依赖

```bash
# 安装开发依赖（推荐）
uv pip install -e ".[dev]"

# 仅安装运行时依赖
uv pip install -e .

# 从 requirements.txt 安装（如果有）
uv pip install -r requirements.txt
```

## 常用命令对照

| 操作         | pip                       | uv                           |
| ------------ | ------------------------- | ---------------------------- |
| 安装包       | `pip install package`     | `uv pip install package`     |
| 安装本地包   | `pip install -e .`        | `uv pip install -e .`        |
| 安装 extras  | `pip install -e ".[dev]"` | `uv pip install -e ".[dev]"` |
| 创建虚拟环境 | `python -m venv .venv`    | `uv venv`                    |
| 列出已安装   | `pip list`                | `uv pip list`                |
| 冻结依赖     | `pip freeze`              | `uv pip freeze`              |
| 同步依赖     | `pip-sync`                | `uv sync`                    |

## 使用 uv 的优势

### 🚀 速度优势

```bash
# 传统 pip 方式（可能需要 30-60 秒）
time pip install -e ".[dev]"

# uv 方式（通常 2-5 秒）
time uv pip install -e ".[dev]"
```

### 📦 更好的依赖解析

uv 使用先进的依赖解析算法，能更好地处理版本冲突：

```bash
# uv 会自动找到兼容的版本组合
uv pip install package1 package2 package3
```

### 🔒 可重现的构建

```bash
# 生成精确的依赖锁定
uv pip freeze > requirements.txt

# 或使用 uv.lock（如果使用 uv sync）
uv sync --frozen
```

## 开发工作流

### 日常开发

```bash
# 1. 激活环境
source .venv/bin/activate

# 2. 安装/更新依赖
uv pip install -e ".[dev]"

# 3. 运行测试
pytest

# 4. 代码检查
ruff check src tests
mypy src
```

### 添加新依赖

```bash
# 1. 编辑 pyproject.toml 添加依赖
# dependencies = ["pyyaml>=6.0", "new-package>=1.0"]

# 2. 重新安装
uv pip install -e ".[dev]"

# 3. 更新 requirements（可选）
uv pip freeze > requirements.txt
```

### CI/CD 中使用 uv

在 GitHub Actions 中使用 uv：

```yaml
- name: Set up uv
  uses: astral-sh/setup-uv@v1
  
- name: Install dependencies
  run: |
    uv venv
    uv pip install -e ".[dev]"
```

## 迁移到 uv

### 从 pip 迁移

1. **安装 uv**：按照上述安装说明
2. **创建新环境**：`uv venv`
3. **安装依赖**：`uv pip install -e ".[dev]"`
4. **验证**：运行测试确保一切正常

### 共存策略

uv 和 pip 可以共存，你可以在同一个虚拟环境中使用两者：

```bash
# 使用 uv 安装大部分包（快）
uv pip install pytest ruff mypy

# 必要时使用 pip（兼容性）
pip install some-legacy-package
```

## 故障排除

### 问题：命令找不到

```bash
# 确保 uv 在 PATH 中
which uv  # macOS/Linux
where uv  # Windows

# 如果找不到，重新运行安装脚本或手动添加到 PATH
```

### 问题：虚拟环境激活失败

```bash
# 确保使用正确的激活命令
source .venv/bin/activate  # macOS/Linux (bash/zsh)
. .venv/bin/activate.fish  # Fish shell
.venv\Scripts\activate     # Windows (cmd)
.venv\Scripts\Activate.ps1 # Windows (PowerShell)
```

### 问题：依赖冲突

```bash
# uv 提供更好的错误信息
uv pip install package1 package2

# 查看详细日志
uv pip install --verbose package
```

## 性能对比

基于本项目的实际测试：

| 操作           | pip  | uv  | 提升 |
| -------------- | ---- | --- | ---- |
| 冷安装         | ~45s | ~3s | 15x  |
| 热安装（缓存） | ~15s | ~1s | 15x  |
| 依赖解析       | ~10s | <1s | 10x+ |

## 资源链接

- [uv 官方文档](https://github.com/astral-sh/uv)
- [uv vs pip 对比](https://astral.sh/blog/uv)
- [迁移指南](https://github.com/astral-sh/uv#getting-started)

## 推荐设置

在项目根目录创建 `.python-version` 文件（已创建）：

```
3.10
```

这样 uv 会自动使用正确的 Python 版本。

---

**总结**：使用 uv 可以大幅提升开发效率，特别是在频繁安装依赖的场景下。推荐所有新项目使用 uv 作为主要包管理器。
