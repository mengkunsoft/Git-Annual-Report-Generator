# Git Annual Report Generator

一个用于生成Git仓库年度提交分析报告的Shell脚本工具。该工具能够深入分析您的Git仓库在指定年份的开发活动，并提供详细的统计数据和可视化报告。

## 功能特性

### 📊 基础统计

- 总提交次数统计
- 作者活跃度排名及占比分析
- 提交高峰日TOP5

### ⏰ 时间维度分析
- 月度提交趋势分析
- 每周提交模式分析（按星期分布）
- 每日时段分析（24小时分布）

### 🔧 代码变更分析
- 代码行数统计（添加/删除/净增）
- 文件修改频率TOP10
- 提交消息关键词分析

### 🌿 分支管理分析
- 合并操作统计
- 新分支创建情况
- 开发节奏分析

## 使用方法

### 快速开始

1. **克隆或下载项目**
```bash
git clone git@github.com:mengkunsoft/Git-Annual-Report-Generator.git
cd Git-Annual-Report-Generator
```
克隆完成后，将 `Git-Annual-Report-Generator.sh` 脚本文件放置到您的目标Git仓库根目录下。

2. **运行脚本**（在Git仓库根目录下执行）

```bash
./Git-Annual-Report-Generator.sh
```

3. **查看生成的报告**
```bash
# 报告将生成在仓库根目录下
cat git_annual_report_2025.md
```

### 自定义配置

编辑脚本文件，修改以下变量来自定义分析范围：

```bash
# 设置报告文件名
REPORT_FILE="git_custom_report.md"

# 设置分析时间段
YEAR_START="2025-01-01"
YEAR_END="2025-12-31"
```

## 报告内容示例

生成的报告包含以下章节：

```
# Git本地仓库年度提交分析报告 (2025)

## 一、基础提交统计
- 总提交次数统计
- 作者活跃度排名
- 提交高峰日分析

## 二、时间维度分析
- 月度提交趋势（表格形式）
- 每周提交模式（按星期分布）
- 每日时段分析（24小时分布）

## 三、代码变更分析
- 代码增删行数统计
- 文件修改频率TOP10
- 提交消息关键词分析

## 四、分支与合并分析
- 合并操作次数统计
- 新分支创建情况

## 五、开发节奏分析
- 提交间隔统计
- 最长无提交间隔分析

## 六、建议与改进
基于分析结果提出的优化建议
```

## 系统要求

- **操作系统**: Linux, macOS, Windows（需要Git Bash或WSL）
- **Git版本**: 1.8.0 或更高版本
- **Shell环境**: Bash 或兼容的Shell环境

## 输出格式

报告以Markdown格式生成，支持：
- ✅ GitHub/GitLab渲染
- ✅ 文本编辑器查看
- ✅ 转换为PDF/HTML等格式

## 注意事项

1. **权限要求**: 确保对Git仓库有读取权限
2. **目录要求**: 需要在Git仓库根目录下运行脚本
3. **时间范围**: 默认分析当前年份，可手动修改
4. **数据完整**: 需要完整的历史记录以获得准确分析

## 扩展使用

### 批量分析多个年份

```bash
#!/bin/bash
for year in 2023 2024 2025; do
    sed -i "s/YEAR_START=\"2025-01-01\"/YEAR_START=\"${year}-01-01\"/" Git-Annual-Report-Generator.sh
    sed -i "s/YEAR_END=\"2025-12-31\"/YEAR_END=\"${year}-12-31\"/" Git-Annual-Report-Generator.sh
    ./Git-Annual-Report-Generator.sh
    mv git_annual_report_2025.md "git_report_${year}.md"
done
```

### 集成到CI/CD流程

可以将此脚本集成到持续集成流程中，自动生成开发团队的活动报告。

## 许可证

本项目采用MIT许可证。详见LICENSE文件。

## 贡献

欢迎提交Issue和Pull Request来改进这个项目！

---

**项目最后更新**: 2026年1月12日  
**脚本版本**: 1.0  
**兼容性**: Git 1.8.0+