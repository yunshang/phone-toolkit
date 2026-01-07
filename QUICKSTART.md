# 📋 Phone Parser - 快速参考

## 🚀 快速开始（30秒）

```bash
# 1. 安装 uv（一次性）
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. 设置项目（自动创建 venv 并安装依赖）
cd /Users/alshin/www/phone/phone_py
make setup

# 3. 运行测试验证
make test

# 4. 开始使用（无需手动激活，Makefile 自动处理）
.venv/bin/python -c "from phone_parser import parse; print(parse('+385915125486'))"
```

> **注意**: Makefile 已更新，现在会自动使用 `.venv/bin/` 中的工具，无需手动激活虚拟环境！

## 📦 常用命令

### 环境管理
| 命令                         | 说明                             |
| ---------------------------- | -------------------------------- |
| `make setup`                 | 一键设置（创建 venv + 安装依赖） |
| `source .venv/bin/activate`  | 激活虚拟环境                     |
| `uv pip install -e ".[dev]"` | 安装/更新依赖                    |

### 开发
| 命令              | 说明                 |
| ----------------- | -------------------- |
| `make test`       | 运行测试（带覆盖率） |
| `make lint`       | 代码检查             |
| `make format`     | 代码格式化           |
| `make type-check` | 类型检查             |
| `make qa`         | **运行所有质量检查** |

### 其他
| 命令         | 说明         |
| ------------ | ------------ |
| `make help`  | 显示所有命令 |
| `make clean` | 清理构建产物 |
| `make build` | 构建分发包   |

## 💡 代码示例

### 解析电话号码
```python
from phone_parser import parse

phone = parse("+385915125486")
print(phone.country_code)  # "+385"
print(phone.area_code)     # "91"
print(phone.number)        # "5125486"
```

### 格式化
```python
phone.format("default")     # "+385915125486"
phone.format("europe")      # "+385 (0) 91 512 5486"
phone.format("us")          # "(91) 512-5486"
phone.format("%A/%f-%l")    # "091/512-5486"
```

### 验证
```python
from phone_parser import is_valid

is_valid("+385915125486")   # True
is_valid("invalid")         # False
```

### 国家查找
```python
from phone_parser import CountryRegistry

country = CountryRegistry.find_by_code("1")
print(country.name)  # "United States"

country = CountryRegistry.find_by_iso_code("US")
print(country.country_code)  # "1"
```

## 🛠️ 工具对比

| 特性     | pip  | uv     |
| -------- | ---- | ------ |
| 安装速度 | 45秒 | 3秒 ⚡  |
| 依赖解析 | 慢   | 超快 ⚡ |
| 缓存     | 基础 | 智能 🧠 |
| 推荐度   | ⭐⭐⭐  | ⭐⭐⭐⭐⭐  |

## 📁 项目结构

```
phone_py/
├── src/phone_parser/    # 源代码
│   ├── __init__.py     # 公共 API
│   ├── country.py      # 国家元数据
│   └── phone.py        # 核心解析
├── tests/              # 测试用例
├── Makefile           # 任务自动化 ⭐
├── .python-version    # Python 版本 ⭐
└── pyproject.toml     # 项目配置
```

## 📚 文档导航

| 文件                                       | 内容          |
| ------------------------------------------ | ------------- |
| [README.md](README.md)                     | 用户文档      |
| [UV_GUIDE.md](UV_GUIDE.md)                 | uv 详细教程 ⭐ |
| [DEVELOPMENT.md](DEVELOPMENT.md)           | 开发指南      |
| [PROJECT_OVERVIEW.md](PROJECT_OVERVIEW.md) | 架构说明      |
| [UV_INTEGRATION.md](UV_INTEGRATION.md)     | uv 集成总结 ⭐ |

## 🔥 推荐工作流

### 开发新功能
```bash
# 1. 确保环境已设置
make setup  # 只需第一次运行

# 2. 编写代码
# 编辑 src/phone_parser/*.py

# 3. 运行测试（无需激活 venv）
make test

# 4. 质量检查
make qa

# 5. 提交代码
git commit -am "Add feature"
```

> **注意**: 所有 `make` 命令会自动使用虚拟环境，无需手动激活！

### 修复 Bug
```bash
# 1. 写测试（TDD）
# 编辑 tests/test_phone.py

# 2. 运行测试（应该失败）
make test

# 3. 修复代码
# 编辑 src/

# 4. 验证修复
make qa
```

## ⚡ 性能提示

1. **首次使用安装 uv**：10-15倍速度提升
2. **使用 Makefile**：简化命令，减少出错
3. **激活环境后开发**：避免重复激活

## 🆘 常见问题

### Q: make test 报错 "No such file or directory"？
```bash
# 确保已运行过 make setup
make setup

# 或者只安装依赖
make install-dev
```

### Q: uv 未找到？
```bash
# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh
# 重启终端
```

### Q: 依赖冲突？
```bash
# uv 有更好的错误提示
uv pip install -e ".[dev]" --verbose
```

### Q: 想用 pip？
```bash
# 完全兼容，直接用 pip
pip install -e ".[dev]"
```

## 🎯 下一步

1. ✅ 阅读 [UV_GUIDE.md](UV_GUIDE.md) 了解更多
2. ✅ 运行 `make test` 验证设置
3. ✅ 编写你的第一个电话号码解析器！

---

**快速帮助**: `make help` | **完整教程**: [UV_GUIDE.md](UV_GUIDE.md)
