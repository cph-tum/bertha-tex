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

if(__FORMAT_BERTHA_INCLUDED)
  return()
endif()
set(__FORMAT_BERTHA_INCLUDED TRUE)

include(FormatLATEX)
include(FormatCMAKE)

# add target "format"
add_custom_target(
  format
  DEPENDS format_latex
  DEPENDS format_cmake
)

# add target "check_format"
add_custom_target(
  check_format
  DEPENDS check_format_latex
  DEPENDS check_format_cmake
)
