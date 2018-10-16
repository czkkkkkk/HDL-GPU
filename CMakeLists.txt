cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(HDL-GPU LANGUAGES CXX CUDA)

include(CTest)
include_directories(${PROJECT_SOURCE_DIR})

# VecAdd
add_library(VecAdd
	vec_add/vec_add.cu
	)
target_compile_features(VecAdd PUBLIC cxx_std_11)
set_target_properties(VecAdd PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(vec_add_test vec_add/test.cu)
set_target_properties(vec_add_test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(vec_add_test VecAdd)

add_test(NAME TestVecAdd COMMAND vec_add_test)

# PreSum
add_library(PreSum
	prefix_sum/prefix_sum.cu
	)

target_compile_features(PreSum PUBLIC cxx_std_11)
set_target_properties(PreSum PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(pre_sum_test prefix_sum/test.cu)
set_target_properties(pre_sum_test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(pre_sum_test PreSum)

add_test(NAME TestPreSum COMMAND pre_sum_test)

