mkdir %PREFIX%\lib
mkdir %PREFIX%\lib\pyright\
mkdir %PREFIX%\lib\pyright\pyright-python
mkdir %PREFIX%\lib\pyright\pyright-python\%PKG_VERSION% 

@REM errors if we don't &&
@REM see https://github.com/prefix-dev/rattler-build/issues/1165
@REM this location is assumed by pyright-python
@REM https://github.com/RobertCraigie/pyright-python/blob/f319c1034087287f79f7a8f57df8fe7bc96d5dda/src/pyright/_utils.py#L46
pnpm config set symlink false  && ^
pnpm install pyright@%PKG_VERSION% --prefix=%PREFIX%\lib\pyright\pyright-python\%PKG_VERSION% && ^
pushd %PREFIX%\lib\pyright\pyright-python\%PKG_VERSION%  && ^
pnpm-licenses generate-disclaimer --prod --output-file=%SRC_DIR%\third-party-licenses.txt && ^
popd

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1