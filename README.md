# Homebrew Python

Install latest official Python releases for macOS from
[python.org](https://www.python.org/).

## Formulae

- python-3.8
- python-3.7

## How do I install these formulae?
```console
$ brew tap jmfederico/python
$ brew cask install <formula>
```

## How do I uninstall these formulae?
```console
$ brew cask uninstall <formula>
```

And if you want to leave no traces of your user installed python packages:
```console
$ brew cask zap <formula>
```

## What gets installed?
- [x] Python Framework
- [x] GUI Applications
- [x] Python Documentation
- [x] Install or upgrade pip

### What is not installed?
- [ ] UNIX command-line tools
- [ ] Shell profile updater

## Where do I find the Python binaries?
`/Library/Frameworks/Python.framework/Versions/<version>/bin/`

For **ZSH** users, you can add them to your `path`:
```sh
# ~/.zprofile
path=(
  /Library/Frameworks/Python.framework/Versions/*/bin
  $path
)
```

## How to I invoke a specific version?
```console
$ python3.7 --version
Python 3.7.5

$ python3.8 --version
Python 3.8.0
```
