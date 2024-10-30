set -euxo pipefail


pnpm install pyright@$PKG_VERSION --prefix=$PREFIX/lib
pnpm list
pnpm-licenses generate-disclaimer --prod --json-input --output-file=$SRC_DIR/third-party-licenses.txt