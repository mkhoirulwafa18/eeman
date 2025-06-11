@echo off

:: Build AAB with debug symbols
flutter clean
flutter build appbundle --flavor "production" --target "lib/main.dart" --release --split-debug-info=build\symbols --obfuscate

:: Create deploy directory with timestamp
set DEPLOY_DIR=deploy_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%
mkdir releases/%DEPLOY_DIR%

:: Copy AAB
copy build\app\outputs\bundle\productionRelease\app-production-release.aab releases\%DEPLOY_DIR%\

:: Copy Dart debug symbols
xcopy /E /I build\symbols releases\%DEPLOY_DIR%\dart-symbols\

:: Copy native debug symbols from specified path
mkdir %DEPLOY_DIR%\native-symbols
xcopy /E /I build\app\intermediates\merged_native_libs\productionRelease\out\lib\* releases\%DEPLOY_DIR%\native-symbols\

echo ✅ Production build complete!
echo AAB: releases\%DEPLOY_DIR%\app-production-release.aab
echo Dart Symbols: releases\%DEPLOY_DIR%\dart-symbols
echo Native Symbols: releases\%DEPLOY_DIR%\native-symbols