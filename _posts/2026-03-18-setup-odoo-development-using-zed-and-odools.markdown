---
title:  "Setup Odoo Development using Zed + OdooLS as Symlink User"
date:   2026-03-18 00:30:00
categories: [odoo]
tags: [python, odoo]
---

Setup Odoo Development using Zed + OdooLS as Symlink User cukup challenging, mengingat kedua Tools tersebut tidak support `symlink` by default. pada tulisan ini, saya akan membagikan cara saya untuk mengatasi masalah tersebut.

## Challenges

Sebagai pengguna `symlink` dalam kehidupan depan laptop sehari-hari, setup Zed + OdooLS cukup challenging karena kedua _Tools_ tersebut tidak support `symlink` by default.

- `Zed` - tidak support `symlink` pada Search Project files (`CMD` + `p`) dan Project Search (`g` + `/`)
- `Odoo-ls` - tidak support `symlink` pada saat read config dan module resolvers.
- `Odoo-ls` - tidak support Odoo Version < 14.0 (saya masih menggunakan Odoo 13.0)

## Solutions

Setelah menghabiskan 7 Jam lebih, akhirnya saya dapat _`monkey patch`_ untuk mengatasi kebutuhan saya. yaitu dengan compile `Zed` dan `Odoo-ls` sendiri dengan beberapa perubahan code yang saya butuhkan.

## Building the Tools

### Dependencies
- `rust` - Using rustup [https://rust-lang.org/tools/install/](https://rust-lang.org/tools/install/)
- `XCode` - Install dari App Store
- `cmake` - Install via Homebrew `brew install cmake`

### Building custom Zed

Setelah malukan perubahan dari source dengan bantuan AI, saya melakukan build Zed dengan mengikuti tutorial: [https://zed.dev/docs/development/macos](https://zed.dev/docs/development/macos)

```bash
git clone https://github.com/zed-industries/zed.git
```

Patch menggunakan code dari [https://github.com/zed-industries/zed/pull/51382](https://github.com/zed-industries/zed/pull/51382)

Kemudian lakukan build

```bash
# /inside/directory/of/zed
cargo run --release
```

_NOTE: pertama kali build akan lama karena download semua dependencies_

Hasil build akan berada di `target/release` dengan nama file `zed`

Jika menggunakan Zed Editor dari Application MacOS, dan ingin menggunakan hasil build ini. lakukan copy `zed` kedalam `/Applications/Zed.app/Contents/MacOS`

```bash
cp target/release/zed /Applications/Zed.app/Contents/MacOS
```

Taraa 🙌 kamu sudah berhasil build `zed` dari source code

### Build custom Odoo-ls

Clone custom Odoo-ls

```bash
git clone -b patch-symlink https://github.com/repodevs/odoo-ls.git
```

Build odoo-ls

```bash
cd odoo-ls/server
```

```bash
cargo build --bin odoo_ls_server --release --target aarch64-apple-darwin
```

Hasil output berada di `target/aarch64-apple-darwin/release/` dengan nama `odoo_ls_server`

Kemudian copy hasil release kedalam Zed Extension Odoo

_NOTE: pastikan remove `odoo_ls_server` terlebih dahulu_

```bash
rm "~/Library/Application Support/Zed/extensions/work/odoo/1.2.0/odoo_ls_server"
```

kemudian copy

```bash
cp target/aarch64-apple-darwin/release/odoo_ls_server "~/Library/Application Support/Zed/extensions/work/odoo/1.2.0"
```

Kemudian Restart Zed Language Servers

### Setup Odoo-ls in Zed

Workspace directory contohnya adalah `~/workspace/myodooproject` yang berisi:

```bash
$ tree -a    
.
├── .zed
│   └── settings.json
├── custom_addons -> ~/workspace/labs/odoo/addons/oca/payroll
├── odoo -> ~/workspace/labs/odoo/master/odoo13
└── odools.toml
```

Buat file `odools.toml` didalam Workspace

```toml
[[config]]
name = "myprofile"
odoo_path = "~/workspace/myodooproject"
addons_paths = ["~/workspace/myodooproject/addons", "~/workspace/myodooproject/custom_addons"]
python_path = "/Users/repodevs/.pyenv/versions/myodooenv/bin/python"
file_cache = false
```

Kemudian custom zed `settings.json`

```jsonc
// .zed/settings.json
{
  "lsp": {
    "odoo": {
      "settings": {
        "Odoo": {
          "selectedProfile": "myprofile"
        }
      }
    }
  }
}
```


Taraa kamu sudah berhasil setup Zed + Odoo-ls dengan Symlink method. Happy Coding 🙌
