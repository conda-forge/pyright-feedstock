set -euxo pipefail

mkdir -p $PREFIX/lib/pyright
pnpm install pyright@$PKG_VERSION --prefix=$PREFIX/lib/pyright
pnpm list

pushd $PREFIX/lib/pyright
pnpm-licenses generate-disclaimer --prod --output-file=$SRC_DIR/third-party-licenses.txt
popd