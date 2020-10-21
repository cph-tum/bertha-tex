%
% bertha-tex: Project skeleton for scientific writing in LaTeX.
%
% Copyright 2020 Michael Haider <michael.haider@tum.de>
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bertha-tex-article}[2020/10/21 v0.1]

% Load required packages
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage[misc]{ifsym}
\RequirePackage{placeins}
\RequirePackage{pgffor}
\RequirePackage{pgfkeys}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% Handle widows and orphans
\widowpenalty=10000
\clubpenalty=10000
\displaywidowpenalty=10000

% Load base class
\PassOptionsToClass{bibtotoc,numbers=noenddot}{scrartcl}
\PassOptionsToClass{\@classoptionslist}{scrartcl}
\LoadClass{scrartcl}

% title block fonts
\setkomafont{title}{\LARGE}
\setkomafont{subtitle}{\large}
\setkomafont{author}{\large}
\newkomafont{affiliation}{\small}
\setkomafont{date}{\footnotesize}

% Handling affiliations
\newcounter{AffiliationCounter}

\newcommand{\affiliation}[2][]{
  \stepcounter{AffiliationCounter}

  % get current automatic affilation number
  \edef\@tmp@mark@{\theAffiliationCounter}

  % store affiliation information
  \pgfqkeys{/bertha-tex/affiliations/\theAffiliationCounter}{
    name/.initial = {#2},
    mark/.initial,
    mark/.expand once=\@tmp@mark@,
    #1
  }
}

% print affiliation mark (only when there is more than one affiliation)
\newcommand{\@affiliationmark}[1]{%
  \ifnumgreater{\theAffiliationCounter}{1}{\textsuperscript{#1}}{}%
}

% print affiliation block
\newcommand{\theAffiliation}{%
  \foreach \x in {1,...,\theAffiliationCounter}{%
    \@affiliationmark{\pgfkeysvalueof{/bertha-tex/affiliations/\x/mark}}%
    \pgfkeysvalueof{/bertha-tex/affiliations/\x/name}\par%
  }%
}

% Handling authors
\newcounter{AuthorCounter}

\renewcommand{\author}[2][]{
  \stepcounter{AuthorCounter}

  % get current automatic affilation number
  \edef\@tmp@affil@{\number\numexpr\theAffiliationCounter+1\relax}

  % store author information
  \pgfqkeys{/bertha-tex/authors/\theAuthorCounter}{
    name/.initial = {#2},
    email/.initial,
    orcid/.initial,
    affil/.initial,
    affil/.expand once=\@tmp@affil@,
    #1
  }
}

% author separator (typically `,`)
\newcommand{\@auth@sep@}{,}

% author final separator (typically, `and`)
\newcommand{\@auth@fsep@}{and}

% print author list
\renewcommand{\@author}{%
  \foreach \x in {1,...,\theAuthorCounter}{%
    \pgfkeysvalueof{/bertha-tex/authors/\x/name}%
    \@affiliationmark{\pgfkeysvalueof{/bertha-tex/authors/\x/affil}}%
    \edef\@tmp@email@{\pgfkeysvalueof{/bertha-tex/authors/\x/email}}%
    \ifdefempty{\@tmp@email@}{}{\textsuperscript{~\Letter}}%
    \ifnumless{\x}{\theAuthorCounter}{%
      \ifnumequal{\x}{\theAuthorCounter-1}{%
        \ifnumgreater{\theAuthorCounter}{2}{%
          \@auth@sep@{}}{} \@auth@fsep@{} %
      }{\@auth@sep@{} }%
    }{}%
  }%
}


% Handling e-mail addresses
% set e-mail address for current author
\newcommand{\email}[1]%
{\pgfkeys{/bertha-tex/authors/\theAuthorCounter/email=#1}}

% print e-mail addresses
\newcommand{\theEmail}{%
  \foreach \x in {1,...,\theAuthorCounter}{%
    \edef\@tmp@email@{\pgfkeysvalueof{/bertha-tex/authors/\x/email}}%
    \ifdefempty{\@tmp@email@}{}{%
      \Letter{}~\@tmp@email@\par%
    }%
  }%
}

% Custom title
\renewcommand{\@maketitle}{
  \newpage
  \begingroup
  \centering
  {\usekomafont{title}\@title\par}
  \ifdefempty{\@subtitle}{}{
    \vspace{.3em}
    {\usekomafont{subtitle}\@subtitle\par}
  }
  \vspace{1.5em}
  {\usekomafont{author}\@author\par}
  \vspace{.3em}
  {\usekomafont{affiliation}\theAffiliation\par}
  \ifdefempty{\theEmail}{}{
    \vspace{.25em}
    {\usekomafont{affiliation}\theEmail\par}
  }
  \ifdefstring{\@date}{}{}{
    \vspace{.25em}
    {\usekomafont{date}\@date\par}
  }
  \vspace{1.5em}
  \endgroup
  \FloatBarrier
}

% Custom abstract
\makeatletter
\renewenvironment{abstract}{%
  \setlength{\parindent}{0mm}
  \textbf{\abstractname}
  \normalfont{---}}{}
\makeatother
