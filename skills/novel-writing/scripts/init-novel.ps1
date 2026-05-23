# 初始化 novel/ 目录（从 templates 复制）
param(
    [string]$Target = "novel"
)

$repoRoot = $null
$dir = $PSScriptRoot
for ($i = 0; $i -lt 6; $i++) {
    $candidate = Join-Path $dir "skills\novel-writing\templates"
    if (Test-Path $candidate) {
        $repoRoot = $dir
        break
    }
    $parent = Split-Path $dir -Parent
    if ($parent -eq $dir) { break }
    $dir = $parent
}

if (-not $repoRoot) {
    Write-Error "请在仓库根目录执行，或确保存在 skills/novel-writing/templates"
    exit 1
}

$src = Join-Path $repoRoot "skills\novel-writing\templates"
$dst = Join-Path (Get-Location) $Target
if ((Get-Location).Path -ne $repoRoot) {
    if (-not (Test-Path (Join-Path (Get-Location) $Target))) {
        $dst = Join-Path (Get-Location) $Target
    }
}

if (Test-Path $dst) {
    Write-Warning "目录已存在: $dst （仅复制缺失文件）"
}

$dirs = @(
    $dst,
    "$dst/background",
    "$dst/background/imports",
    "$dst/characters",
    "$dst/plot",
    "$dst/state",
    "$dst/chapters"
)
foreach ($d in $dirs) {
    New-Item -ItemType Directory -Force -Path $d | Out-Null
}

$files = @{
    "README.md" = "$dst/README.md"
    "meta.yaml" = "$dst/meta.yaml"
    "relationships.md" = "$dst/relationships.md"
    "characters/_index.md" = "$dst/characters/_index.md"
    "plot/outline.md" = "$dst/plot/outline.md"
    "plot/arcs.md" = "$dst/plot/arcs.md"
    "plot/tasks.md" = "$dst/plot/tasks.md"
    "plot/digest.md" = "$dst/plot/digest.md"
    "plot/chapter-plan.md" = "$dst/plot/chapter-plan.md"
    "state/continuity.md" = "$dst/state/continuity.md"
    "state/short-term.md" = "$dst/state/short-term.md"
    "state/next-chapter.md" = "$dst/state/next-chapter.md"
    "background/_index.md" = "$dst/background/_index.md"
    "background/core.md" = "$dst/background/core.md"
    "background/world.md" = "$dst/background/world.md"
    "background/history.md" = "$dst/background/history.md"
    "background/factions.md" = "$dst/background/factions.md"
    "background/locations.md" = "$dst/background/locations.md"
    "background/imports/README.txt" = "$dst/background/imports/README.txt"
}

foreach ($rel in $files.Keys) {
    $from = Join-Path $src $rel
    $to = $files[$rel]
    if (-not (Test-Path $to)) {
        if (Test-Path $from) {
            Copy-Item $from $to
            Write-Host "已创建 $to"
        } else {
            Write-Warning "模板缺失: $from"
        }
    } else {
        Write-Host "已存在，跳过 $to"
    }
}

Write-Host "完成。请编辑 $dst/background/ 、plot/outline.md ，并添加人物卡。"
