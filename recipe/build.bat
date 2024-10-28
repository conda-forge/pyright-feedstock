@echo on

REM Install Python dependencies
%PYTHON% -m pip install . || goto :error

REM Set environment variables
set PYRIGHT_PYTHON_CACHE_DIR=%PREFIX%\lib
echo "shamefully-hoist=true" > %HOME%\.npmrc

pnpm config list

pyright-langserver --node-ipc || goto :error

REM Create activation script directory and set the Pyright cache location
mkdir %PREFIX%\etc\conda\activate.d || goto :error
echo "set PYRIGHT_PYTHON_CACHE_DIR=%PREFIX%\lib" > %PREFIX%\etc\conda\activate.d\10-set-npm-pyright-location.bat || goto :error

REM Navigate to Pyright's cache directory
pushd %PYRIGHT_PYTHON_CACHE_DIR%\pyright-python\%PKG_VERSION%\node_modules\pyright\ || goto :error

REM Install dependencies and generate third-party licenses file
pnpm install --shamefully-hoist || goto :error
pnpm licenses list --json | pnpm-licenses generate-disclaimer --prod --json-input --output-file=%SRC_DIR%\third-party-licenses.txt || goto :error

popd

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1