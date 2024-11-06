@echo on

mkdir %PREFIX%\lib\pyright
pnpm install pyright@%PKG_VERSION% --prefix=%PREFIX%\lib\pyright || goto :error

pushd %PREFIX%\lib\pyright && pnpm-licenses generate-disclaimer --prod --json-input --output-file=%SRC_DIR%\third-party-licenses.txt || goto :error

popd

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1