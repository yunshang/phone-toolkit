#!/bin/bash
# 验证 uv 设置脚本

set -e

echo "🔍 检查 uv 安装..."
if ! command -v uv &> /dev/null; then
    echo "❌ uv 未安装"
    echo "📦 安装 uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "✅ uv 已安装"
else
    echo "✅ uv 已安装: $(uv --version)"
fi

echo ""
echo "🐍 检查 Python 版本..."
if [ -f .python-version ]; then
    echo "✅ 找到 .python-version 文件: $(cat .python-version)"
else
    echo "⚠️  未找到 .python-version 文件"
fi

echo ""
echo "📦 检查虚拟环境..."
if [ -d .venv ]; then
    echo "✅ 虚拟环境已存在"
else
    echo "📦 创建虚拟环境..."
    uv venv
    echo "✅ 虚拟环境已创建"
fi

echo ""
echo "📥 安装依赖..."
source .venv/bin/activate
uv pip install -e ".[dev]"

echo ""
echo "🧪 运行快速测试..."
python -c "from phone_parser import parse; phone = parse('+385915125486'); print(f'✅ 解析成功: {phone.format(\"default\")}')"

echo ""
echo "🎉 验证完成！"
echo ""
echo "下一步："
echo "  1. 激活虚拟环境: source .venv/bin/activate"
echo "  2. 运行测试: make test"
echo "  3. 查看所有命令: make help"
