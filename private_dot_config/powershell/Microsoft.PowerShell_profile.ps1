function Install-UserModuleIfMissing {
  Param($module)

  if (Get-Module -ListAvailable -Name $module) {
  } else {
    Install-Module $module -Scope CurrentUser @Args
  }
}

Install-UserModuleIfMissing posh-git -AllowPrerelease -Force
Install-UserModuleIfMissing PSReadLine -AllowPrerelease -Force
Install-UserModuleIfMissing nvm

# Copy of the robby russell theme
function Prompt {
  if ($?) {
      Write-Host '➜' -NoNewline -ForegroundColor Green
  }
  else {
      Write-Host '➜' -NoNewline -ForegroundColor Red
  }

  Write-Host ("  " + $(Split-Path -path $pwd  -Leaf)) -NoNewline -ForegroundColor Cyan

  $gitStatus = Get-GitStatus
  if ($gitStatus) {
      Write-Host " git:(" -NoNewline -ForegroundColor Blue
      Write-Host "$($gitStatus.Branch)" -NoNewline -ForegroundColor Red
      Write-Host ")" -NoNewline -ForegroundColor Blue

      if ($gitStatus.Working.Length -gt 0) {
          Write-Host (" " + [char]::ConvertFromUtf32(10007)) -NoNewline -ForegroundColor Yellow
      }
  }

  return " "
}

# directory movement aliases
function upOneDir {
  Set-Location ..
}
function upTwoDir {
  Set-Location ../..
}
function upThreeDir {
  Set-Location .. /../..
}
function upFourDir {
  Set-Location .. /../../..
}
Set-Alias -Name '..' upOneDir
Set-Alias -Name '...' upTwoDir
Set-Alias -Name '....' upThreeDir
Set-Alias -Name '.....' upFourDir

# List directory contents with pretty colours
if ($IsLinux) {
  function ls {
      /bin/ls --color=auto $args
  }
  function la {
      ls -Ah $args
  }
  function ll {
      ls -lh $args
  }
  Set-Alias l ll
}
if ($IsMac) {
  function ls {
      /bin/ls -G $args
  }
  function la {
      ls -Ah $args
  }
  function ll {
      ls -lh $args
  }
  Set-Alias l ll
}


# Up and Down arrows go back through history
Set-PSReadlineKeyHandler -Key UpArrow -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
Set-PSReadlineKeyHandler -Key DownArrow -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchForward()
  [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
# Tabbing to be like zsh rather than bash
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Jump words
Set-PSReadlineKeyHandler -Key Ctrl+LeftArrow BackwardWord
Set-PSReadlineKeyHandler -Key Ctrl+RightArrow ForwardWord

# Nvm with nice UX!
function nvm {
  $node_version = Get-Content ./.nvmrc -Raw
  if (Get-NodeVersions -Filter $node_version) {
      Write-Host 'Already installed:' $node_version
  }
  else {
      Install-NodeVersion
  }
  Set-NodeVersion
  node -v
}

# Add things to the PATH
# $ENV:PATH += ":$HOME/.jabba/bin"  # Java
# $ENV:PATH += ":$HOME/.rbenv/bin"  # Ruby
# $ENV:PATH += ":$HOME/projects/tools/idea-IU-193.5233.102/bin" #Idea
