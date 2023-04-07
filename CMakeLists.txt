cmake_minimum_required(VERSION 3.1)

project(Stencil CUDA CXX)

set(CMAKE_CUDA_STANDARD 20)
set(CMAKE_CUDA_STANDARD_REQUIRED TRUE)
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -arch=sm_61 -std=c++17")

add_executable(stencil 
    main.cpp
    src/stencil_kernel.cu
)

target_include_directories(stencil PRIVATE
    src
    include
)

target_link_libraries(stencil PUBLIC cuda)