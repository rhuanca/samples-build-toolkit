cmake_minimum_required(VERSION 2.8)
project(read_tag_ids)

SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)

link_directories(${CMAKE_SOURCE_DIR}/libs)
include_directories(${CMAKE_SOURCE_DIR}/curl/include)

set(SOURCE_FILES main.c parson.c)
add_executable(read_tag_ids ${SOURCE_FILES})

target_link_libraries(read_tag_ids ${CMAKE_SOURCE_DIR}/libs/libcurl.a)