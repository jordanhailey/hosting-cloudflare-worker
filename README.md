# Hosting Test - Cloudflare Worker

This is a test of hosting a Hugo site on a Cloudflare Worker.

This site:

1. Includes content from a Hugo module
1. Transpiles Sass to CSS using Dart Sass
1. Performs vendor prefixing of CSS rules using the postcss, postcss-cli, and autoprefixer Node.js packages
1. Processes CSS files using the tailwindcss and @tailwindcss-cli Node.js packages
1. Encodes images to the WebP format to verify that we're using Hugo's extended edition
1. Includes a content file named hugö.md to verify that the Git `core.quotepath` setting is `false`[^1].

Notes:

1. This repository uses a [GitHub Action] to update `scheduled-file-update.txt` every day at approximately[^2] 9:57 PM UTC. Each update triggers a Cloudflare Worker build.
1. Cloudflare uses Zstd compression, which is faster to compress/decompress than Brotli, but the compression ratio is generally lower than Brotli. This difference is noise.
3. Environment variables defined under the `vars` key in a `wrangler.toml` file are not available to the build script. This is the expected behavior. Set the desired versions in `build.sh` file instead.

[GitHub Action]: https://github.com/jmooring/hosting-cloudflare-worker/blob/main/.github/workflows/scheduled-file-update.yaml

[^1]: See [issue #9810](https://github.com/gohugoio/hugo/issues/9810). Git's `core.quotepath` setting is `false` if `/tests/hugö` has a non-zero "last modified" date.

[^2]: The time at which the cron job actually runs varies depending on GitHub's load.
