# ==========================================================================
# HELPFUL INFO
# ==========================================================================

# How to swap prediction view inside a script:
# [Microsoft.PowerShell.PSConsoleReadLine]::SwitchPredictionView($key, $arg)

# List of default PSReadLine colors:
# InlinePrediction              = "#444444"               # dark gray
# CommandColor                  = "$([char]0x1b)[93m"     # bright yellow
# CommentColor                  = "$([char]0x1b)[32m"     # green
# ContinuationPromptColor       = "$([char]0x1b)[33m"     # yellow
# DefaultTokenColor             = "$([char]0x1b)[33m"     # yellow
# EmphasisColor                 = "$([char]0x1b)[96m"     # bright cyan
# ErrorColor                    = "$([char]0x1b)[91m"     # bright red
# KeywordColor                  = "$([char]0x1b)[92m"     # bright green
# MemberColor                   = "$([char]0x1b)[97m"     # bright white
# NumberColor                   = "$([char]0x1b)[97m"     # bright white
# OperatorColor                 = "$([char]0x1b)[90m"     # bright black (gray)
# ParameterColor                = "$([char]0x1b)[90m"     # bright black (gray)
# SelectionColor                = "$([char]0x1b)[35;43m   # magenta on yellow
# StringColor                   = "$([char]0x1b)[36m"     # cyan
# TypeColor                     = "$([char]0x1b)[37m"     # white
# VariableColor                 = "$([char]0x1b)[92m"     # bright green


# ==========================================================================
# Helper functions
# ==========================================================================

# function HexToEsc {
#     param (
#         [string]$HexColor
#     )

#     $rgb = $HexColor -replace '^#', '' | ForEach-Object { [convert]::ToInt32($_, 16) }
#     $escapeSequence = "`e[38;2;$($rgb -shr 16);$($rgb -shr 8 -band 0xFF);$($rgb -band 0xFF)m"
#     return $escapeSequence
# }


# ==========================================================================
# Imports
# ==========================================================================

Import-Module -Name Terminal-Icons
Import-Module PSReadLine


# ==========================================================================
# Misc Tweaks
# ==========================================================================

# Prevent cursor blinking
Write-Host -NoNewLine "`e[6 q"

# Disable beep
Set-PSReadlineOption -BellStyle None


# ==========================================================================
# Vi Mode
# ==========================================================================

# Enable Vi mode
Set-PSReadLineOption -EditMode Vi

# change cursor for different vi modes
# 1 => blinking block
# 2 => steady block
# 3 => blinking underline
# 4 => steady underline
# 5 => blinking bar
# 6 => steady bar
$NORMAL = 2
$INSERT = 6
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[$($NORMAL) q"
    }
    else {
        Write-Host -NoNewLine "`e[$($INSERT) q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange


# ==========================================================================
# Predictive completion (must stay after Vi mode)
# ==========================================================================

# Default values
$defaultSource = 'History'
$defaultView = 'InlineView'
Set-PSReadLineOption -PredictionSource $defaultSource -PredictionViewStyle $defaultView

# Toggle predictions on/off
function TogglePredictions {
    $currentSource = (Get-PSReadLineOption).PredictionSource
    if ($currentSource -eq 'None') {
        Set-PSReadLineOption -PredictionSource History -PredictionViewStyle InlineView
    }
    else {
        Set-PSReadLineOption -PredictionSource None
    }
}

# Switch between list and menu view, turn on if they are off
function OnAndSwitchPredictionView {
    $currentSource = (Get-PSReadLineOption).PredictionSource
    if ($currentSource -eq 'None') {
        Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::SwitchPredictionView($key, $arg)
    }
}

# Remove current command from history
function RemoveFromHistory {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    $toRemove = [Regex]::Escape(($line -replace "\n", "```n"))
    $history = Get-Content (Get-PSReadLineOption).HistorySavePath -Raw
    $history = $history -replace "(?m)^$toRemove\r\n", ""
    Set-Content (Get-PSReadLineOption).HistorySavePath $history -NoNewline
}

# Keybindings
# RightArrow - Accepts entire suggestion (default keybind)
Set-PSReadLineKeyHandler -Chord "Shift+RightArrow" -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -ScriptBlock $function:TogglePredictions
Set-PSReadLineKeyHandler -Chord "Ctrl+j" -ScriptBlock $function:OnAndSwitchPredictionView
Set-PSReadLineKeyHandler -Chord "Shift+Backspace" -ScriptBlock $function:RemoveFromHistory
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete


# ==========================================================================
# VIFM (File Manager)
# ==========================================================================

$env:VIFM = 'C:/Users/Luke/.config/vifm'


# ==========================================================================
# Volta (node version manager, replaces nvm, installed with scoop)
# ==========================================================================

(& volta completions powershell) | Out-String | Invoke-Expression # enables tab completions


# ==========================================================================
# Colors
# ==========================================================================

# Custom colors
Set-PSReadLineOption -Colors @{
    InlinePrediction = '#3c3c3c'
    # Command            = 'Magenta'
    # Number             = 'Magenta'
    # Member             = 'DarkGray'
    # Operator           = 'DarkGreen'
    # Type               = 'DarkGray'
    # Variable           = 'DarkGreen'
    # Parameter          = 'DarkGreen'
    # ContinuationPrompt = 'DarkGray'
    # Default            = 'DarkGray'
}


# ==========================================================================
# Aliases
# ==========================================================================

Remove-Alias -Name 'r'
New-Alias -Name 'r' -Value 'vifm'
New-Alias -Name 'vim' -Value 'nvim'


# ==========================================================================
# oh-my-posh
# ==========================================================================

# initialisation
oh-my-posh init pwsh --config 'C:/Users/Luke/.config/oh-my-posh/lpke-min.omp.json' | Invoke-Expression
