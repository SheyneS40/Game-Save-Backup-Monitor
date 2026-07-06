# Game-Save-Backup-Monitor
A lightweight PowerShell script that automatically creates backup copies of your game saves.

Русская версия

Небольшой PowerShell-скрипт для автоматического резервного копирования игровых сохранений.

Создавался во время прохождения **Divinity: Original Sin Enhanced Edition** на режиме **Honor Mode**, где существует только одно сохранение, а смерть всей группы приводит к его потере.

Однако скрипт не привязан к какой-либо конкретной игре и может использоваться для любых игр, в которых необходимо регулярно создавать резервные копии сохранений.

## Возможности

- Автоматически отслеживает изменения в папке сохранений.
- Создаёт резервную копию только после изменения файлов.
- Ждёт завершения записи файлов перед копированием.
- Хранит только заданное количество последних резервных копий.
- Не требует установки сторонних программ.
- Работает на Windows с помощью PowerShell.

## Как это работает

1. Скрипт периодически проверяет содержимое папки с сохранениями.
2. Если обнаружено изменение:
   - ожидает несколько секунд, чтобы игра завершила запись файлов;
   - создаёт новую резервную копию;
   - при необходимости удаляет самые старые архивы.

Каждая копия сохраняется в отдельную папку с отметкой времени:

```
backup_2026-07-06_03-15-42
backup_2026-07-06_03-28-19
backup_2026-07-06_03-41-07
```

## Настройка

Необходимо изменить две переменные:

```powershell
$Source
$BackupRoot
```

- **$Source** — папка игровых сохранений.
- **$BackupRoot** — место хранения резервных копий.

Также можно изменить:

```powershell
$IntervalSeconds
```

— интервал проверки изменений.

И

```powershell
$KeepLastBackups
```

— количество сохраняемых резервных копий.

## Запуск

```powershell
powershell -ExecutionPolicy Bypass -File ".\GameSaveBackup.ps1"
```

## Для каких игр подходит

Скрипт подойдёт практически для любых игр, где сохранения представлены обычными файлами:

- Divinity: Original Sin
- Divinity: Original Sin 2
- Baldur's Gate 3
- XCOM
- Battle Brothers
- RimWorld (Commitment Mode)
- Project Zomboid
- и многих других.

## Примечание

Этот проект **не изменяет игровые сохранения**, не вмешивается в процесс игры и не взаимодействует с памятью процесса.

Он лишь автоматически создаёт резервные копии файлов сохранений.


==============================================================================

English

A lightweight PowerShell script that automatically creates backup copies of your game saves.

Originally written while playing **Divinity: Original Sin Enhanced Edition** in **Honor Mode**, where the game only allows a single save file and a full party wipe may end the entire playthrough.

The script is game-independent and can be used with any game that stores saves as regular files.

## Features

- Monitors your save folder for changes.
- Creates backups only when saves actually change.
- Waits for the game to finish writing files before copying.
- Automatically removes old backups.
- No third-party software required.
- Pure PowerShell.

## How it works

1. Periodically checks the save directory.
2. Detects file changes.
3. Waits a few seconds to ensure the save operation is complete.
4. Copies the save folder into a timestamped backup.
5. Keeps only the latest configured number of backups.

Example:

```
backup_2026-07-06_03-15-42
backup_2026-07-06_03-28-19
backup_2026-07-06_03-41-07
```

## Configuration

Adjust the following variables:

```powershell
$Source
$BackupRoot
```

- **$Source** – game save directory.
- **$BackupRoot** – backup destination.

Optional settings:

```powershell
$IntervalSeconds
```

Polling interval.

```powershell
$KeepLastBackups
```

Maximum number of backups to keep.

## Running

```powershell
powershell -ExecutionPolicy Bypass -File ".\GameSaveBackup.ps1"
```

## Compatible games

Works with virtually any game that stores saves as regular files, for example:

- Divinity: Original Sin
- Divinity: Original Sin 2
- Baldur's Gate 3
- XCOM
- Battle Brothers
- RimWorld (Commitment Mode)
- Project Zomboid
- and many others.

## Notes

This project **does not modify game saves**, inject code into games, or interact with game memory.

It simply creates automated backup copies of save files.


=============================================================================

## Почему?

Этот скрипт появился во время прохождения *Divinity: Original Sin Enhanced Edition* на режиме **Honor Mode**.

Когда стало понятно, что одна внезапная ловушка, неудачный бой или особенно коварная игровая ситуация могут стереть десятки часов прогресса, захотелось простого и надёжного способа автоматически сохранять резервные копии — без необходимости сворачивать игру и делать это вручную.

Так появился небольшой PowerShell-скрипт, который тихо работает в фоне, следит за изменениями в папке сохранений и может пригодиться не только для Divinity, но и для многих других игр с permadeath, ironman-режимом или одним-единственным слотом сохранения.

## Why?

This script was born during an Honor Mode playthrough of Divinity: Original Sin Enhanced Edition.

After realizing that a single unexpected trap, scripted encounter, or unfortunate combat could erase dozens of hours of progress, I wanted a simple and reliable way to create automatic save backups without interrupting gameplay.

The result is a lightweight PowerShell utility that quietly runs in the background and can be reused with many other games featuring permadeath or single-save mechanics.
