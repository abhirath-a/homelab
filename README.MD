# Dendritic NixOS Homelab

This is the configuration for my [NixOS](https://nixos.org/) Homelab.

This configuration is built using [Flake Parts](https://flake.parts/), [sops-nix](https://github.com/mic92/sops-nix), and the [Dendritic Nix Pattern](https://github.com/mightyiam/dendritic).

## Machine(s)
### Sherbet

This machine is an old laptop with an [Intel Pentium Gold 4415U](https://www.intel.com/content/www/us/en/products/sku/96508/intel-pentium-gold-processor-4415u-2m-cache-2-30-ghz/specifications.html) and 4 gigabytes of RAM.

Services

|Icon|Name|Description|Category|
|---|---|---|---|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/glance.svg" width=32 height=32>|[Glance](https://github.com/glanceapp/glance)|Self-hosted dashboard for aggregating feeds, bookmarks, and widgets|Services|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/miniflux.svg" width=32 height=32>|[Miniflux](https://miniflux.app)|Minimalist and opinionated RSS feed reader|Services|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/navidrome.svg" width=32 height=32>|[Navidrome](https://navidrome.org)|Self-hosted web-based music streaming server and Subsonic backend|Media|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/searxng.svg" width=32 height=32>|[Searxng](https://searxng.org)|Private, open-source metasearch engine aggregating results from multiple services|Services|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/vaultwarden.svg" width=32 height=32>|[Vaultwarden](https://github.com/dani-garcia/vaultwarden)|Lightweight unofficial Bitwarden compatible password manager written in Rust|Services|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/wireguard.svg" width=32 height=32>|[Wireguard](https://www.wireguard.com/repositories/)|Fast, modern, and secure VPN tunnel protocol|Networking|
|<img src="https://camo.githubusercontent.com/3012a345bb5498cf20dbbf6bdb079b7a44697aaf470f5a3275d1c1a7750eca93/68747470733a2f2f746563686e697469756d2e636f6d2f696d672f6c6f676f2e706e67" width=32 height=32>|[Technetium](https://github.com/TechnitiumSoftware/DnsServer)|Recursive DNS Resolver and DNS Sinkhole|Networking|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/caddy.svg" width=32 height=32>|[Caddy](https://caddyserver.com/)|Fast, modern web server with automatic HTTPS via Let's Encrypt|Networking|
|<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/cloudflare.svg" width=32 height=32>|[Cloudflare DDNS](https://github.com/timothymiller/cloudflare-ddns)|Tool to automatically update dynamic DNS records on Cloudflare|Networking|
