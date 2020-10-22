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


cmake_minimum_required(VERSION 3.9)

# project information
set(PROJECT "bertha-tex")
set(PROJECT_AUTHOR "Michael Haider")
set(PROJECT_EMAIL "michael.haiderh@tum.de")
set(PROJECT_URL "https://www.gitlab.com/cph-tum/bertha-tex")
set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)
set(VERSION_PRRLS "")
set(VERSION_CORE "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")
set(VERSION_FULL "${VERSION_CORE}${VERSION_PRRLS}")
project(${PROJECT} VERSION ${VERSION_CORE} LANGUAGES NONE)

# require CMake UseLATEX package
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(UseLATEX)

# add LaTeX documents
add_latex_document(
  bertha-tex.tex
  INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR}/templates
  BIBFILES references.bib
  FORCE_PDF
)
