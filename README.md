# pedivieweR

[![R-CMD-check](https://github.com/Thymine2001/pedivieweR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Thymine2001/pedivieweR/actions)

**pedivieweR** is an interactive R Shiny application for pedigree data quality control, inbreeding analysis, and interactive network visualization.  
It allows you to load pedigree datasets, perform quality checks, calculate inbreeding coefficients, and visualize complex pedigree networks in real time.

---

## ✨ Features
- 📂 **Pedigree data preview** – Upload CSV, TXT, or PED files and instantly view the pedigree structure  
- 🔍 **Quality control** – Fast pedigree QC with Rcpp acceleration, detect duplicate IDs, missing parents, and self-parenting issues  
- 📊 **Inbreeding analysis** – Calculate inbreeding coefficients (F) for all individuals using pedigreeTools  
- 🌐 **Interactive visualization** – Navigate complex pedigree networks with visNetwork, search individuals, and explore relationships  
- 🎯 **Smart aggregation** – Automatic hierarchical clustering for large datasets (family, super-family, mega-family levels)  
- 💡 **Export tools** – Download QC reports, fixed pedigrees, inbreeding data, and selected individual ranges  

---

## 🛠️ Installation

Install the development version from GitHub:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("Thymine2001/pedivieweR")
```

Install from a local source tarball:

``` r
setwd("C:/Users/YourPath/")
remotes::install_local("pedivieweR_0.1.0.tar.gz", dependencies = TRUE)
```

## 🚀 Usage

After installation, load the package and run the app:

``` r
library(pedivieweR)
run_pedivieweR()
```

A Shiny app will launch in your default browser, allowing interactive pedigree exploration.

### Advanced Options

``` r
# Launch on a specific port
run_pedivieweR(port = 3838)

# Launch without opening browser
run_pedivieweR(launch.browser = FALSE)

# Launch on all network interfaces
run_pedivieweR(host = "0.0.0.0", port = 3838)
```

## 📦 Dependencies

The package will install the following key dependencies automatically:
- shiny
- bslib
- shinyjs
- dplyr
- DT
- pedigreeTools
- visNetwork
- igraph
- digest
- Rcpp (optional, for accelerated QC)

## 📖 Example Workflow

1. Launch the app using `run_pedivieweR()`.
2. Upload a pedigree dataset (CSV, TXT, or PED format).
3. Auto-detect ID, Sire, Dam, and Sex columns.
4. Review QC report and fix any data issues.
5. Calculate inbreeding coefficients for all individuals.
6. Search and visualize specific individuals or families.
7. Export filtered data, F values, or QC reports.

## 🤝 Contributing

Contributions are welcome!
- Report issues via the [Issues page](https://github.com/Thymine2001/pedivieweR/issues).
- Submit pull requests to improve features or documentation.

If you use pedivieweR in your research or projects, we'd love to hear your feedback!

## 📜 License

This project is released under the GPL-3 License.

---

# pedivieweR 中文说明

pedivieweR 是一个交互式 R Shiny 应用，用于系谱数据质量控制、近交分析和交互式网络可视化。  
它可以加载系谱数据集，执行质量检查，计算近交系数，并实时可视化复杂的系谱网络。

## ✨ 功能特性

📂 系谱数据预览 -- 上传 CSV、TXT 或 PED 文件并即时查看系谱结构<br>
🔍 质量控制 -- 使用 Rcpp 加速的快速系谱 QC，检测重复 ID、缺失亲本和自我亲缘问题<br>
📊 近交分析 -- 使用 pedigreeTools 为所有个体计算近交系数 (F)<br>
🌐 交互式可视化 -- 使用 visNetwork 导航复杂的系谱网络，搜索个体并探索关系<br>
🎯 智能聚合 -- 大型数据集自动分层聚类（家系、超级家系、巨型家系层级）<br>
💡 导出工具 -- 下载 QC 报告、修复的系谱、近交数据和选定的个体范围<br>

## 🛠️ 安装

从 GitHub 安装开发版：

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("Thymine2001/pedivieweR")
```

从本地源文件安装：

``` r
setwd("C:/Users/YourPath/")
remotes::install_local("pedivieweR_0.1.0.tar.gz", dependencies = TRUE)
```

## 🚀 使用方法

安装完成后，加载包并运行应用：

``` r
library(pedivieweR)
run_pedivieweR()
```

浏览器将启动一个 Shiny 应用，允许交互式系谱探索。

### 高级选项

``` r
# 在特定端口启动
run_pedivieweR(port = 3838)

# 不打开浏览器启动
run_pedivieweR(launch.browser = FALSE)

# 在所有网络接口上启动
run_pedivieweR(host = "0.0.0.0", port = 3838)
```

## 📦 依赖

该包会自动安装以下主要依赖：
- shiny
- bslib
- shinyjs
- dplyr
- DT
- pedigreeTools
- visNetwork
- igraph
- digest
- Rcpp（可选，用于加速 QC）

## 📖 示例工作流

1. 使用 `run_pedivieweR()` 启动应用。
2. 上传系谱数据集（CSV、TXT 或 PED 格式）。
3. 自动检测 ID、Sire、Dam 和 Sex 列。
4. 查看 QC 报告并修复任何数据问题。
5. 为所有个体计算近交系数。
6. 搜索并可视化特定个体或家系。
7. 导出过滤数据、F 值或 QC 报告。

## 🤝 贡献

欢迎贡献！
- 通过 [Issues 页面](https://github.com/Thymine2001/pedivieweR/issues) 报告问题。
- 提交 pull requests 以改进功能或文档。

如果你在研究或项目中使用 pedivieweR，我们非常期待你的反馈！

## 📜 许可证

该项目基于 GPL-3 许可证发布。
