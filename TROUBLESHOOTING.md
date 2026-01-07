# 故障排除指南

## 常见问题解决方案

### ❌ 问题：`make test` 报错 "pytest: No such file or directory"

**原因**: 虚拟环境未创建或依赖未安装。

**解决方案**:
```bash
# 方案 1: 完整重新设置
make setup

# 方案 2: 仅安装依赖
make install-dev

# 验证
make test
```

---

### ❌ 问题：`make: *** [test] Error 1` 且提示 "Virtual environment not found"

**原因**: `.venv` 目录不存在。

**解决方案**:
```bash
# 创建虚拟环境
make venv

# 或直接运行完整设置
make setup
```

---

### ❌ 问题：`uv: command not found`

**原因**: uv 未安装。

**解决方案**:
```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# 重启终端后验证
uv --version

# 如果仍无法找到，使用 pip 安装
pip install uv
```

**备选方案**: 使用 pip（Makefile 会自动回退）
```bash
# 直接使用 pip 也可以工作
python -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
```

---

### ❌ 问题：测试失败（某些测试用例不通过）

**症状**:
```
FAILED tests/test_phone.py::TestPhoneParsing::test_parse_with_country_code
```

**这不是错误！** 这是当前代码的已知问题，表示某些功能尚未完全实现或测试用例需要调整。

**验证 Makefile 工作正常**:
- ✅ 如果看到测试运行了（即使有失败）
- ✅ 如果看到覆盖率报告
- ✅ Makefile 配置是正确的

---

### ❌ 问题：`ImportError: No module named 'phone_parser'`

**原因**: 包未安装在可编辑模式。

**解决方案**:
```bash
# 安装包
make install-dev

# 验证
.venv/bin/python -c "import phone_parser; print(phone_parser.__version__)"
```

---

### ❌ 问题：`make: Nothing to be done for 'test'` 或类似消息

**原因**: Makefile 缓存问题。

**解决方案**:
```bash
# 清理缓存
make clean

# 重新测试
make test
```

---

### ❌ 问题：权限错误（Permission denied）

**症状**:
```
./verify_uv.sh: Permission denied
```

**解决方案**:
```bash
# 添加执行权限
chmod +x verify_uv.sh

# 重新运行
./verify_uv.sh
```

---

### ❌ 问题：虚拟环境激活后仍使用系统 Python

**检查**:
```bash
which python
# 应该显示: /path/to/phone_py/.venv/bin/python
```

**解决方案**:
```bash
# 使用 Makefile 命令，无需手动激活
make test  # 自动使用 .venv/bin/pytest

# 或显式激活
source .venv/bin/activate
which python
```

---

### ❌ 问题：依赖版本冲突

**症状**:
```
ERROR: Cannot install phone-toolkit because these package versions have conflicting dependencies
```

**解决方案（使用 uv - 推荐）**:
```bash
# uv 有更好的依赖解析
make clean
rm -rf .venv
uv venv
uv pip install -e ".[dev]"
```

**解决方案（使用 pip）**:
```bash
# 升级 pip
.venv/bin/pip install --upgrade pip

# 重新安装
make install-dev
```

---

### ❌ 问题：Coverage 警告 "module-not-measured"

**症状**:
```
CoverageWarning: Module phone_parser was previously imported, but not measured
```

**这是警告，不是错误！** 可以忽略，或通过以下方式修复：

**解决方案**:
```bash
# 清理之前的导入缓存
make clean
make test
```

---

## 验证安装

运行以下命令验证所有设置正确：

```bash
# 1. 检查虚拟环境
ls -la .venv/bin/python && echo "✅ Virtual environment exists"

# 2. 检查依赖
.venv/bin/pip list | grep -E "pytest|ruff|mypy" && echo "✅ Dependencies installed"

# 3. 运行快速测试
.venv/bin/python -c "from phone_parser import parse; print('✅ Import works')"

# 4. 运行 Makefile 测试
make test-quick
```

---

## 完全重置

如果一切都失败了，完全重置：

```bash
# 1. 清理所有内容
make clean
rm -rf .venv

# 2. 重新开始
make setup

# 3. 验证
make test
```

---

## 获取帮助

- **查看所有 Makefile 命令**: `make help`
- **查看 uv 帮助**: 阅读 [UV_GUIDE.md](UV_GUIDE.md)
- **开发文档**: 阅读 [DEVELOPMENT.md](DEVELOPMENT.md)
- **快速参考**: 阅读 [QUICKSTART.md](QUICKSTART.md)

---

## 诊断信息收集

如果需要报告问题，收集以下信息：

```bash
# 系统信息
uname -a
python --version

# uv 信息
uv --version || echo "uv not installed"

# 环境检查
ls -la .venv/ 2>/dev/null || echo ".venv not found"

# 依赖列表
.venv/bin/pip list 2>/dev/null || echo "Cannot list dependencies"

# Makefile 测试
make help
```
