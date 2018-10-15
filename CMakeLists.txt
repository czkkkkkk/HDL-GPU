cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(HDL-GPU LANGUAGES CXX CUDA)

include(CTest)
include_directories(${PROJECT_SOURCE_DIR})

add_library(VecAdd
	vec_add/vec_add.cu
	)

target_compile_features(VecAdd PUBLIC cxx_std_11)

set_target_properties(VecAdd PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(vec_add_test vec_add/test.cu)
set_target_properties(vec_add_test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(vec_add_test VecAdd)

add_test(NAME test1 COMMAND vec_add_test)
