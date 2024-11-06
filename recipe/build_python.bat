@echo on

REM Install Python dependencies
%PYTHON% -m pip install .

REM Create activation script directory and set the Pyright cache location
mkdir %PREFIX%\etc\conda\activate.d
echo "set PYRIGHT_PYTHON_CACHE_DIR=%PREFIX%\lib\pyright" > %PREFIX%\etc\conda\activate.d\10-set-npm-pyright-location.bat || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1