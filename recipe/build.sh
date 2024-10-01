set -euxo pipefail

$PYTHON -m pip install .

export PYRIGHT_PYTHON_CACHE_DIR="$PREFIX/lib"
pyright-langserver --node-ipc

mkdir -p $PREFIX/etc/conda/activate.d
echo 'export PYRIGHT_PYTHON_CACHE_DIR="$PREFIX/lib"' > $PREFIX/etc/conda/activate.d/10-set-npm-pyright-location.sh

pushd $PYRIGHT_PYTHON_CACHE_DIR/pyright-python/$PKG_VERSION/node_modules/pyright/

# generate third party licenses file
pnpm install
pnpm licenses list --json | pnpm-licenses generate-disclaimer --prod --json-input --output-file=$SRC_DIR/third-party-licenses.txt

popd