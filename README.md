# U-Boot

This is UKO's fork of U-Boot.
Our current development board for [ukoos] needs U-Boot patches that haven't been upstreamed, and we're also making our own modifications past them.

[ukoos]: https://github.com/UMN-Kernel-Object/ukoos

The following branches exist in this repo:

| Branch Name | Description |
|:------------|:------------|
| `trunk`     | You are here. This is just a placeholder for documentation. |
| [`sg200x`](https://github.com/UMN-Kernel-Object/u-boot/tree/sg200x) | This is based on the [sg200x branch](https://github.com/sophgo/u-boot-2021.10/tree/sg200x-dev) of [sophgo/u-boot-2021.10](https://github.com/sophgo/u-boot-2021.10). |

If you're hacking on this, you might want to add upstream U-Boot and the vendor repos as remotes.
Copy-paste-able block:

```sh
git clone git@github.com:UMN-Kernel-Object/u-boot.git
cd u-boot
git remote add upstream git@github.com:u-boot/u-boot.git
git remote add sophgo git@github.com:sophgo/u-boot-2021.10.git
git fetch --all
```
