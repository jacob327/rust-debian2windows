# rust-debian2windows

## What is this?
Cross-compile exapmple from linux to windows

## Usage

### Get Started

install required packages, toolchains, targets.
```bash
./init.sh
```

### Compile
```bash
cargo build
```

### Execute

Prepare
```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y wine32
```

Execute
```bash
wine ./target/i686-pc-windows-gnu/debug/mt4_dll.exe
```

## LICENSE
MIT
