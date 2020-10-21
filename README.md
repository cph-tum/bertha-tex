# bertha-tex

Project skeleton for scientific writing in LaTeX.

This project skeleton aims to provide a clean and solid basis for scientific
paper writing in LaTeX. It enables the use of predefined templates such that
scientists can easily contribute to different scientific journals or
conferences that typically require to use their own specific templates. The
skeleton might also be used as a starting point for more advanced thesis or
book projects. The project skeleton includes several features that facilitate
good software engineering practices:

 - Usage of a version control system (VCS) and an appropriate work flow
 - Usage of a project management tool including issue tracking
 - Automated build system using CMake
 - Automated packaging and deployment
 - Automatic code formatting checks using latexindent and cmake-format

## Get the code

Make sure to clone using

    git clone --recurse-submodules [...]

in order to clone the third-party libraries recursively. Alternatively, issue

    git submodule update --init --recursive

in the repository if it already exists.
