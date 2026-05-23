Write-Host "Set TLS1.2"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"
choco install -y nsis.portable --ignore-checksums &&
./scripts/winflexbison_install.ps1

od.exe --version &&

vcpkg.exe integrate install &&

mkdir build &&
cd build &&
cmake.exe .. -A x64 -DVCPKG_TARGET_TRIPLET=x64-windows-static -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake -DBOOST_ROOT="$env:BOOST_ROOT" -DBOOST_LIBRARYDIR="$env:BOOST_LIBRARYDIR" -DBoost_USE_STATIC_LIBS=ON -DENABLE_REGRESSION=On -DBUILD_TESTING=On -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=C:/deps/esbmc -DENABLE_PYTHON_FRONTEND=On -DENABLE_SOLIDITY_FRONTEND=On -DENABLE_JIMPLE_FRONTEND=On -DDOWNLOAD_DEPENDENCIES=On -DENABLE_Z3=ON -DENABLE_SMTLIB=OFF &&
cmake --build . --target INSTALL  --config RelWithDebInfo
