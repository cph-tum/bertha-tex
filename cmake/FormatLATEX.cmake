#
# bertha-tex: Project skeleton for scientific writing in LaTeX.
#
# Copyright 2021 Michael Haider <michael.haider@tum.de>
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

if(__FORMAT_LATEX_INCLUDED)
  return()
endif()
set(__FORMAT_LATEX_INCLUDED TRUE)

# setup format directories
set(FORMAT_CRUFT_DIR "${PROJECT_BINARY_DIR}/format")
set(LATEX_REVISION_FILE "${FORMAT_CRUFT_DIR}/format_latex_revisionlist.txt")

# find latexindent
find_program(LATEXINDENT_EXECUTABLE latexindent REQUIRED)

# find git
find_package(Git REQUIRED)

# find format LaTeX settings
find_file(format_latex_settings "format_latex_settings.yaml"
          PATHS ${PROJECT_SOURCE_DIR}/cmake REQUIRED
)

# get list of all LaTeX files
file(GLOB_RECURSE latex_files *.cls *.sty *.tex)

# format source files only
list(FILTER latex_files EXCLUDE REGEX "${PROJECT_BINARY_DIR}/*.*")
list(FILTER latex_files EXCLUDE REGEX "${PROJECT_SOURCE_DIR}/templates/*")

# add target "format_latex"
add_custom_target(format_latex)

# format each individual LaTeX file
foreach(file ${latex_files})
  add_custom_command(
    TARGET format_latex
    COMMENT "Formatting LaTeX file ${file}"
    COMMAND ${CMAKE_COMMAND} -E make_directory ${FORMAT_CRUFT_DIR}
    COMMAND "${LATEXINDENT_EXECUTABLE}" -w -m -s
            --cruft="${FORMAT_CRUFT_DIR}" --local="${format_latex_settings}"
            "${file}"
  )
endforeach()

# add target "check_format_latex"
add_custom_target(
  check_format_latex
  COMMENT "Checking format of LaTeX files"
  COMMAND "${GIT_EXECUTABLE}" diff --exit-code
          --output="${LATEX_REVISION_FILE}"
  DEPENDS format_latex
)
