# Phone Parser Python - 项目概览

## 📁 项目结构

```
phone_py/
├── .github/
│   └── workflows/
│       └── ci.yml              # GitHub Actions CI/CD配置
├── src/
│   └── phone_parser/           # 源代码（src布局）
│       ├── __init__.py         # 公共API暴露
│       ├── country.py          # 国家元数据和查找逻辑
│       ├── phone.py            # 核心解析和格式化
│       └── py.typed            # PEP 561类型标记
├── tests/
│   ├── __init__.py
│   └── test_phone.py           # 综合测试套件
├── pyproject.toml              # 项目配置（PEP 621）
├── README.md                   # 用户文档
├── DEVELOPMENT.md              # 开发者指南
├── LICENSE                     # MIT许可证
└── .gitignore                  # Git忽略文件
```

## 🎯 核心设计

### 架构模式

1. **嵌入式数据源**
   - 国家元数据作为YAML字符串常量嵌入 `country.py`
   - 模块初始化时解析一次到全局注册表
   - 零外部文件依赖

2. **两阶段解析**
   ```
   输入字符串 → 提取分机号 → 规范化 → 检测国家 → 拆分组件 → Phone对象
   ```

3. **灵活格式化**
   - 预定义格式：`default`, `europe`, `us`
   - 自定义模式：使用 `%` 令牌（类似printf）
   - 线程安全的全局默认值

### 关键类

- **`Country`**: 国家元数据dataclass，带缓存的正则表达式
- **`CountryRegistry`**: 类方法注册表，提供查找功能
- **`Phone`**: 解析后的电话号码，支持多种格式化方式

## 🛠️ 技术栈（2026最佳实践）

| 工具          | 用途               | 配置位置                                   |
| ------------- | ------------------ | ------------------------------------------ |
| **uv**        | 包管理器（推荐）   | `.python-version`                          |
| **Hatchling** | 构建后端           | `pyproject.toml` [build-system]            |
| **Ruff**      | Linter + Formatter | `pyproject.toml` [tool.ruff]               |
| **MyPy**      | 类型检查           | `pyproject.toml` [tool.mypy]               |
| **Pytest**    | 测试框架           | `pyproject.toml` [tool.pytest.ini_options] |
| **Coverage**  | 覆盖率             | `pyproject.toml` [tool.coverage]           |
| **Makefile**  | 任务自动化         | `Makefile`                                 |

## 📝 代码规范

### 类型提示
- **严格模式**: 所有公开API必须有完整类型标注
- **Python 3.10+**: 使用 `str | None` 而非 `Optional[str]`
- **TYPE_CHECKING**: 延迟导入避免循环依赖

### 文档字符串
- **Google风格**: 所有公开函数/类
- **示例代码**: 在docstring中包含用法示例
- **参数说明**: 清晰描述类型和目的

### 测试
- **Pytest风格**: 使用 `assert` 而非 `self.assertEqual`
- **类组织**: 按功能分组测试用例
- **覆盖率目标**: >80%

## 🚀 CI/CD流程

GitHub Actions自动执行：
1. **多版本测试**: Python 3.10-3.13
2. **代码质量检查**:
   - Ruff linting
   - Ruff formatting
   - MyPy类型检查
3. **测试执行**: pytest + 覆盖率报告
4. **构建验证**: 打包并检查元数据

## 🔄 从Go到Python的适配

| Go特性              | Python实现       |
| ------------------- | ---------------- |
| `sync.Mutex`        | `threading.Lock` |
| 函数首字母大写=公开 | `__all__` 列表   |
| `init()`            | 模块级初始化     |
| Slice操作           | 字符串切片 `[:]` |
| 多返回值            | Tuple `(a, b)`   |
| Error返回           | 抛出异常         |

## 📦 依赖策略

### 运行时依赖
- **最小化原则**: 仅 `pyyaml`（YAML解析）
- **无HTTP/DB**: 完全自包含库

### 开发依赖
- 通过 `[dev]` extra安装
- 版本范围宽松但指定下限

## 🎓 学习资源

- [PEP 621](https://peps.python.org/pep-0621/) - pyproject.toml元数据
- [PEP 517/518](https://peps.python.org/pep-0517/) - 构建系统规范
- [Ruff文档](https://docs.astral.sh/ruff/) - 最快的Python linter
- [MyPy文档](https://mypy.readthedocs.io/) - 类型检查
- [Pytest文档](https://docs.pytest.org/) - 测试框架
