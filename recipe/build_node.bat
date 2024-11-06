mkdir %PREFIX%\lib
mkdir %PREFIX%\lib\pyright

@REM errors if we don't &&
pnpm config set symlink false  && ^
pnpm install pyright@%PKG_VERSION% --prefix=%PREFIX%\lib\pyright && ^
pushd %PREFIX%\lib\pyright && ^
pnpm-licenses generate-disclaimer --prod --output-file=%SRC_DIR%\third-party-licenses.txt && ^
popd

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1