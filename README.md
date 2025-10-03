# U-Boot

This is UKO's fork of U-Boot.
Our current development board for [ukoos] needs U-Boot patches that haven't been upstreamed, and we're also making our own modifications past them.

Patches have also been applied from:

- [Fishwaldo/sophgo-sg200x-debian](https://github.com/Fishwaldo/sophgo-sg200x-debian/)

[ukoos]: https://github.com/UMN-Kernel-Object/ukoos

The following branches exist in this repo:

| Branch Name | Description |
|:------------|:------------|
| `trunk`     | You are here. This is just a placeholder for documentation. |
| [`milkv-duos-sd`](https://github.com/UMN-Kernel-Object/u-boot/tree/milkv-duos-sd) | This is based on the [sg200x branch](https://github.com/sophgo/u-boot-2021.10/tree/sg200x-dev) of [sophgo/u-boot-2021.10](https://github.com/sophgo/u-boot-2021.10), with patches applied that are specific to the [Milk-V Duo S](https://milkv.io/duo-s) when booting from microSD. |
| [`spacemit-k1`](https://github.com/UMN-Kernel-Object/u-boot/tree/spacemit-k1) | This is based on the [k1-bl-v2.2.7-release tag](https://gitee.com/bianbu-linux/uboot-2022.10/tree/k1-bl-v2.2.7-release) of [bianbu-linux/u-boot-2022.10](https://gitee.com/bianbu-linux/uboot-2022.10). |

If you're hacking on this, you might want to add upstream U-Boot and the vendor repos as remotes.
Copy-paste-able block:

```sh
git clone git@github.com:UMN-Kernel-Object/u-boot.git
cd u-boot
git remote add upstream git@github.com:u-boot/u-boot.git
git remote add sophgo git@github.com:sophgo/u-boot-2021.10.git
git remote add spacemit https://gitee.com/bianbu-linux/uboot-2022.10.git
git fetch --all
```
