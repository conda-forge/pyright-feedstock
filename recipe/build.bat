@echo on
set -e

REM Install Python dependencies
%PYTHON% -m pip install .

REM Set environment variables
set PYRIGHT_PYTHON_CACHE_DIR=%PREFIX%\lib
echo "shamefully-hoist=true" > %HOME%\.npmrc
pyright-langserver --node-ipc

REM Create activation script directory and set the Pyright cache location
mkdir %PREFIX%\etc\conda\activate.d
echo "set PYRIGHT_PYTHON_CACHE_DIR=%PREFIX%\lib" > %PREFIX%\etc\conda\activate.d\10-set-npm-pyright-location.bat

REM Navigate to Pyright's cache directory
pushd %PYRIGHT_PYTHON_CACHE_DIR%\pyright-python\%PKG_VERSION%\node_modules\pyright\

REM Install dependencies and generate third-party licenses file
pnpm install --shamefully-hoist
pnpm licenses list --json | pnpm-licenses generate-disclaimer --prod --json-input --output-file=%SRC_DIR%\third-party-licenses.txt

popd
