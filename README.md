# 🎀 阿泠 Termux 软件源

这是我的私人 Termux 软件仓库。

## 🩷 添加软件源

```bash
echo "deb [trusted=yes] https://alhkxsj.github.io/termux-repo/ termux extras" >> $PREFIX/etc/apt/sources.list
pkg update
```


## 🚀 使用说明

1. 添加软件源（如上所示）
2. 运行 `pkg update` 更新包列表
3. 安装所需软件包: `pkg install <package-name>`

## 🤝 贡献

如果您想向此仓库添加软件包，请：
1. Fork 仓库
2. 将 `.deb` 文件放入 `pkgs/` 目录
3. 提交 Pull Request

## 📄 许可证

此项目遵循 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。
