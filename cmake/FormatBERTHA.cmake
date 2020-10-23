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
