set -euxo pipefail

# this location is assumed by pyright-python
# https://github.com/RobertCraigie/pyright-python/blob/f319c1034087287f79f7a8f57df8fe7bc96d5dda/src/pyright/_utils.py#L46
mkdir -p $PREFIX/lib/pyright/pyright-python/$PKG_VERSION/
pnpm install pyright@$PKG_VERSION --prefix=$PREFIX/lib/pyright/pyright-python/$PKG_VERSION/
pnpm list

pushd $PREFIX/lib/pyright/pyright-python/$PKG_VERSION/
pnpm-licenses generate-disclaimer --prod --output-file=$SRC_DIR/third-party-licenses.txt
popd