# Days
- The app uses Realm to store your data and shows how many days passed after something happened in your life
- The app supports both English and Russian languages
- UI-elements have color options for both light and dark mode

## Project setup

### First steps

1. Clone the repo
2. Open project folder in terminal 
```shell
cd Days
```
3. Setup hooks directory
```shell
git config core.hooksPath githooks
```
4. Grant permission to `pre-commit` hook
```shell
chmod +x pre-commit
```
5. Open the `xcodeproj`-file and wait for `Xcode` to resolve the packages

### Code formatting

- The project uses [swiftformat (0.50.9)](https://github.com/nicklockwood/SwiftFormat) for code formatting
- Code formatting rules can be found in [.swiftformat](.swiftformat)
- All rules are listed [here](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md)

### How it works
1. Before each commit a pre-commit hook checks for code formatting
2. If any rules are broken, you will get an error and a string with terminal command to run `swiftformat` correctly

### How to update `swiftformat`

1. Open this [page](https://github.com/nicklockwood/SwiftFormat/releases)
2. Download `swiftformat.zip`
3. Change old file with a new one

## What you can do with this app

1. Create records with "+" button
2. Sort records with top left button
3. Save records with "Save" button (record name must contain at least 1 letter)
4. See how many days ago the recorded event took place
5. Remove records with a swipe
6. Send me your feedback
7. Delete all data if you wish
