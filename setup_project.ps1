# setup_project.ps1 - 项目结构整理脚本

$ErrorActionPreference = "SilentlyContinue"

# 设置源目录和目标目录
$sourceBase = Get-Location
$targetBase = Get-Location

Write-Host "=== 开始整理项目结构 ===" -ForegroundColor Green

# 1. 创建目标目录结构
Write-Host "`n[1/4] 创建目录结构..." -ForegroundColor Cyan
$directories = @(
    "src\api\v1",
    "src\core",
    "src\models",
    "src\schemas",
    "src\services",
    "src\utils",
    "src\database",
    "src\tasks",
    "docs",
    "docker",
    "scripts"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "  ✓ 创建：$dir" -ForegroundColor Gray
    }
}

# 2. 复制文档文件
Write-Host "`n[2/4] 复制文档文件..." -ForegroundColor Cyan
$docFiles = @("01_ARCHITECTURE.md", "PROJECT_STRUCTURE.md")
foreach ($file in $docFiles) {
    $source = Get-ChildItem -Recurse -Filter $file | Select-Object -First 1
    if ($source) {
        Copy-Item -Path $source.FullName -Destination "docs\$file" -Force
        Write-Host "  ✓ 复制：$file -> docs\" -ForegroundColor Gray
    } else {
        Write-Host "  ✗ 未找到：$file" -ForegroundColor Yellow
    }
}

# 3. 复制配置文件
Write-Host "`n[3/4] 复制配置文件..." -ForegroundColor Cyan
$configFiles = @(".env.example", ".gitignore", "requirements.txt", "pytest.ini", "docker-compose.yml", "README.md", "QUICK_START.md")
foreach ($file in $configFiles) {
    $source = Get-ChildItem -Recurse -Filter $file | Select-Object -First 1
    if ($source) {
        Copy-Item -Path $source.FullName -Destination ".\$file" -Force
        Write-Host "  ✓ 复制：$file" -ForegroundColor Gray
    } else {
        Write-Host "  ✗ 未找到：$file" -ForegroundColor Yellow
    }
}

# 4. 复制 Docker 相关文件
Write-Host "`n[4/4] 复制 Docker 文件..." -ForegroundColor Cyan
$dockerFiles = @("Dockerfile", "nginx.conf")
foreach ($file in $dockerFiles) {
    $source = Get-ChildItem -Recurse -Filter $file | Select-Object -First 1
    if ($source) {
        Copy-Item -Path $source.FullName -Destination "docker\$file" -Force
        Write-Host "  ✓ 复制：$file -> docker\" -ForegroundColor Gray
    } else {
        Write-Host "  ✗ 未找到：$file" -ForegroundColor Yellow
    }
}

Write-Host "`n=== 项目结构整理完成 ===" -ForegroundColor Green
Write-Host "请检查上述输出，确认所有文件已正确复制" -ForegroundColor Yellow