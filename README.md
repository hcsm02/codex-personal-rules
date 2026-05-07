# Codex Personal Rules

This repository stores personal global Codex skills that should be shared across machines.

Do not sync the whole `~/.codex` directory. Sync only the skills you intentionally maintain here.

## Repository Layout

```text
skills/
  development-discipline/
    SKILL.md
    agents/openai.yaml
```

## First-Time Setup On A Windows Machine

Clone this repository:

```powershell
cd $env:USERPROFILE
git clone https://github.com/hcsm02/codex-personal-rules.git
```

Make sure the Codex skills directory exists:

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\skills"
```

If a local skill directory already exists, back it up:

```powershell
Rename-Item `
  "$env:USERPROFILE\.codex\skills\development-discipline" `
  "development-discipline.backup"
```

Create a junction so Codex reads the Git-backed copy:

```powershell
New-Item -ItemType Junction `
  -Path "$env:USERPROFILE\.codex\skills\development-discipline" `
  -Target "$env:USERPROFILE\codex-personal-rules\skills\development-discipline"
```

Verify:

```powershell
Get-Item "$env:USERPROFILE\.codex\skills\development-discipline" |
  Select-Object FullName, LinkType, Target

Get-Content "$env:USERPROFILE\.codex\skills\development-discipline\SKILL.md" -Encoding UTF8 |
  Select-Object -First 8
```

## Daily Update Workflow

Edit files under:

```text
%USERPROFILE%\codex-personal-rules\skills
```

Commit and push:

```powershell
cd "$env:USERPROFILE\codex-personal-rules"
git status
git add skills README.md
git commit -m "update global codex skills"
git push
```

On another machine, pull updates:

```powershell
cd "$env:USERPROFILE\codex-personal-rules"
git pull
```

Because `.codex\skills\development-discipline` is a junction, Codex will read the updated files after `git pull`.

## Adding Another Global Skill

Create the new skill in this repository:

```text
skills/<skill-name>/SKILL.md
```

Then link it into Codex:

```powershell
New-Item -ItemType Junction `
  -Path "$env:USERPROFILE\.codex\skills\<skill-name>" `
  -Target "$env:USERPROFILE\codex-personal-rules\skills\<skill-name>"
```

Commit and push:

```powershell
cd "$env:USERPROFILE\codex-personal-rules"
git add skills
git commit -m "add <skill-name> skill"
git push
```

## If A Skill Already Exists On A New Machine

Back it up first:

```powershell
Rename-Item `
  "$env:USERPROFILE\.codex\skills\development-discipline" `
  "development-discipline.backup.$(Get-Date -Format yyyyMMddHHmmss)"
```

Then create the junction as shown above.

## If Git Reports Conflicts

Use normal Git conflict resolution:

```powershell
cd "$env:USERPROFILE\codex-personal-rules"
git pull
```

Open conflicted files, keep the desired content, then:

```powershell
git add skills README.md
git commit
git push
```

## Restoring The Local Backup

Remove the junction:

```powershell
Remove-Item "$env:USERPROFILE\.codex\skills\development-discipline"
```

Restore the backup:

```powershell
Rename-Item `
  "$env:USERPROFILE\.codex\skills\development-discipline.backup" `
  "development-discipline"
```

Only remove the junction path itself. Do not delete the repository unless you intentionally want to remove the synced copy.

