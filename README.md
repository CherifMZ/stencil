# stencil

In this repository, we find an example of stencil calculation written in Cuda (https://en.wikipedia.org/wiki/Iterative_Stencil_Loops). 
The main objective is to see how we manage the complexity of large programs by separating compilation and link editing.

PS: this is a very small project which allow us to follow the structure to build a project containing C++ (.cpp and .h) and CUDA (.cu and .cuh) source files.

## Overall structure
```
|--> Stencil/
       |--> CMakeLists.txt
       |--> main.cpp
       |--> src/ stencil_kernel.cuh (source files)
       |--> include/ stencil_kernel.cuh (header files)
```

## Build your project
Make sure you have CMake installed
```
mkdir build
cd build
cmake .. 
cmake --build .
cd Debug 
./stencil.exe
```
