#
# bertha-tex: Project skeleton for scientific writing in LaTeX.
#
# Copyright 2020 Michael Haider <michael.haider@tum.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if(__FORMAT_CMAKE_INCLUDED)
  return()
endif()
set(__FORMAT_CMAKE_INCLUDED TRUE)

# setup format directories
set(FORMAT_CRUFT_DIR "${PROJECT_BINARY_DIR}/format")
set(CMAKE_REVISION_FILE "${FORMAT_CRUFT_DIR}/format_cmake_revisionlist.txt")

# find cmake-format
find_program(CMAKE-FORMAT_EXECUTABLE cmake-format REQUIRED)

# find git
find_package(Git REQUIRED)

# find format CMake settings
find_file(format_cmake_settings "format_cmake_settings.yaml" PATH
          ${PROJECT_SOURCE_DIR}/cmake REQUIRED
)

# get list of all CMake files
file(GLOB_RECURSE cmake_files *.cmake CMakeLists.txt)

# format source files only
list(FILTER cmake_files EXCLUDE REGEX "${PROJECT_BINARY_DIR}/*.*")

# add target "format_cmake"
add_custom_target(format_cmake)

# format each individual CMake file
foreach(file ${cmake_files})
  add_custom_command(
    TARGET format_cmake
    COMMENT "Formatting CMake file ${file}"
    COMMAND ${CMAKE_COMMAND} -E make_directory ${FORMAT_CRUFT_DIR}
    COMMAND "${CMAKE-FORMAT_EXECUTABLE}" -c "${format_cmake_settings}" -i
            "${file}"
  )
endforeach()

# add target "check_format_cmake"
add_custom_target(check_format_cmake DEPENDS "${CMAKE_REVISION_FILE}")

# check format of all CMake files using "git diff"
add_custom_command(
  OUTPUT "${CMAKE_REVISION_FILE}"
  COMMENT "Checking format of CMake files"
  COMMAND "${GIT_EXECUTABLE}" diff --exit-code
          --output="${CMAKE_REVISION_FILE}"
  DEPENDS format_cmake
)
