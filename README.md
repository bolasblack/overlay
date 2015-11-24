# My Portage Overlay

* net-misc/dnscrypt-wrapper: From https://github.com/Cofyc/portage-overlay/tree/master/net-misc/dnscrypt-wrapper
* net-im/telegram-cli: From https://github.com/vysheng/tg/tree/master/gentoo/net-im/telegram-cli

## Usage

```bash
mkdir -p /etc/portage/repos.conf
```

Save content to `/etc/portage/repos.conf/c4605.conf`:

```conf
[c4605]
location = /usr/local/overlays/c4605
sync-type = git
sync-uri = https://github.com/bolasblack/overlay.git
auto-sync = yes
```

```bash
emerge --sync
```
