# bumpcore/docker

Prebuilt PHP + Swoole + Bun images so app deploys skip compiling extensions and installing the toolchain.

```dockerfile
FROM ghcr.io/bumpcore/php-swoole-bun:8.5
```

| Tag | Base |
| --- | --- |
| `8.5`, `latest` | `phpswoole/swoole:php8.5` |
| `8.4` | `phpswoole/swoole:6.2.1-php8.4` |

Each image includes Composer, Bun, Supervisor, and `bcmath`, `exif`, `gd`, `intl`, `pcntl`, `pdo_pgsql`, `pgsql`, `zip`.

Pushes to `main` publish to `ghcr.io/bumpcore/php-swoole-bun`.
