@echo on

:: Configure with CMake
cmake -S . -B build ^
    -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_STANDARD=20 ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DBUILD_TESTING=OFF ^
    -DBUILD_CLI=ON ^
    -DBUILD_BENCHMARKS=OFF
if errorlevel 1 exit 1

:: Build
cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: Install
cmake --install build
if errorlevel 1 exit 1