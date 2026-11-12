#!/usr/bin/env bash
set -euo pipefail

# Jekyll uses convert for responsive WebP images. Avoid an APT mirror
# refresh just to install this one tool on the hosted runner.
if ! command -v convert >/dev/null; then
  prefix="$RUNNER_TEMP/site-imagemagick"
  "$CONDA/bin/conda" create --yes --prefix "$prefix" --override-channels -c conda-forge 'imagemagick=7'
  # Expose ImageMagick without shadowing the Python and Ruby from setup actions.
  image_bin="$RUNNER_TEMP/site-image-bin"
  mkdir -p "$image_bin"
  for name in convert identify magick; do
    ln -sf "$prefix/bin/$name" "$image_bin/$name"
  done
  export PATH="$image_bin:$PATH"
  echo "$image_bin" >> "$GITHUB_PATH"
fi
convert -size 1x1 xc:white "$RUNNER_TEMP/site-image-test.webp"
test -s "$RUNNER_TEMP/site-image-test.webp"
