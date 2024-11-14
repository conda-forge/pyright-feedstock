set -euxo pipefail

$PYTHON -m pip install .

export PYRIGHT_PYTHON_CACHE_DIR="$PREFIX/lib/pyright"

mkdir -p $PREFIX/etc/conda/activate.d
echo 'export PYRIGHT_PYTHON_CACHE_DIR="$CONDA_PREFIX/lib/pyright/"' > $PREFIX/etc/conda/activate.d/10-set-npm-pyright-location.sh
