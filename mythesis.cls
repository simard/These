%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                        %%
%% LaTeX class about PhD thesis redaction %%
%%                                        %%
%% Class file adapt from book.cls         %%
%%                                        %%
%% Juste LAPIN, 21th march 2011           %%
%%                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some tips about the class
%%
%% Source files must be in a subdirectory 'files'.
%% Images must be in a subdirectory 'images' (in EPS format).
%% Data files (like CSV for graphics) must be in a subdirectory 'data'.
%%

% Class name declaration
\NeedsTeXFormat{LaTeX2e}[1999/01/01]
\ProvidesClass{mythesis}[2011/04/29 mythesis]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Declare package options %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options about 'book' class
% Language options
\newif\if@myenglish \@myenglishfalse
\DeclareOption{myenglish}{\@myenglishtrue}
\newif\if@myfrancais \@myfrancaisfalse
\DeclareOption{myfrancais}{\@myfrancaistrue}

\ProcessOptions
\PassOptionsToClass{fleqn}{book}
\PassOptionsToClass{10pt}{book}
\PassOptionsToClass{a4paper}{book}
\LoadClassWithOptions{book}

\if@myenglish
	\PassOptionsToPackage{english}{babel}
	\PassOptionsToPackage{myenglish}{myref}
\fi
\if@myfrancais
	\PassOptionsToPackage{frenchb}{babel}
	\PassOptionsToPackage{myfrancais}{myref}
\fi

%% Packages to call
% About characters encoding
%\RequirePackage[postscript]{ucs}
\RequirePackage[utf8]{inputenc}
% About fonts
\RequirePackage[T1]{fontenc}
% Latin modern fonts offers more choices
% WARNING: there is not bold small caps font
\RequirePackage{lmodern}
% Add bold fonts for TT and small-caps for Computer Modern
% WARNING: Not compatible with Latin Modern ('lmodern' package)
\RequirePackage{bold-extra}
% About language
\RequirePackage{babel}
% Only for number printing
\RequirePackage{numprint}
% About colors
\RequirePackage{xcolor}
% Redefine headers and footers
\RequirePackage{myheadfoot}
% About links in the final PDF document
\RequirePackage[dvips]{hyperref}
% Improve the bookmarks in the PDF
\RequirePackage[dvips]{bookmark}
% To make a glossary
\RequirePackage[acronym]{myglossary}
% All about tabulars
\RequirePackage[smarttab]{myfloat}
% All about the table of contents and other lists
\RequirePackage[chapter,minitoc]{mytoc}
% All about the bibliographies
\RequirePackage[biblatex,backref,minibibsection]{mybib}
% All about making references
\RequirePackage[smartref]{myref}

%%%%%%%%%%%%%%%%%%%%
%% Configurations %%
%%%%%%%%%%%%%%%%%%%%
% Substitute Computer Modern to Latin Modern for bold small caps
\DeclareFontSubstitution{T1}{cmr}{bx}{sc}
%%% hyperref %%%
% Configuration of hyperref package
\hypersetup{%
	pdfnewwindow=true,%
	colorlinks=true,%
	breaklinks=true,%
	pdfhighlight=/P,%
	pdfcenterwindow=true,%
	pdfdisplaydoctitle=true,%
	pdffitwindow=true,%
	pdfstartview=FitH,%
	linkcolor=gray,%
	citecolor=green,%
	filecolor=magenta,%
	urlcolor=red%
}%
%%% biblatex %%%
% To avoid a semi-colon for 'In Proceeedings...' (instead of 'In: Preoceedings...').
\renewcommand{\intitlepunct}{\space}
% To separate each entry in the bibliography with a vertical space
\setlength{\bibparsep}{1ex plus 0.5ex minus 0.2ex}

%% Declare all options
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\logoleft}[1]{\def\@logoleft{#1}}
\newcommand{\logoright}[1]{\def\@logoright{#1}}
\newcommand{\documenttype}[1]{\def\@documenttype{#1}}
\newcommand{\university}[1]{\def\@university{#1}}
\newcommand{\jury}[1]{\def\@jury{#1}}
\newcommand{\signatures}[1]{\def\@signatures{#1}}
\newcommand{\Version}[1]{\def\@Version{#1}}
\newcommand{\VersionDef}[5]{(\mydate[datesep={--}]{#2}{#3}{#4}) Version~#1%
  \begin{quote}%
	#5%
  \end{quote}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Redéfinition des différentes parties %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Redéfinition de \maketitle
\newcommand{\toptitlepage}{
	\ifx\@logoleft\@empty%
	\else%
		\psframebox{\includegraphics[width=3cm]{\@logoleft}}
	\fi
	\hspace{\stretch{1}}
	\ifx\@logoright\@empty%
	\else%
		\psframebox{\includegraphics[width=3cm]{\@logoright}}
	\fi\par
}

\definecolor{myred}{rgb}{0.7265625,0,0}
\newcommand{\bodytitlepage}{
	\normalfont
	\ifx\@documenttype\@empty
	\else
	{\Large\raggedright\textcolor{black!50}{\@documenttype}\par}
	\fi
	{\textcolor{myred}{\rule[0.5ex]{\textwidth}{1pt}}\par}%
	\ifx\@author\@empty
	\else
		{\large\raggedleft \@author\par}
	\fi
	\vfill
	\ifx\@title\@empty
	\else
		{\LARGE\centering \@title\par}
	\fi
	\ifx\@subtitle\@empty
	\else
		{\vspace{0.5cm}\large\centering \begin{otherlanguage}{english}\@subtitle\end{otherlanguage}\par}
	\fi
	\ifx\@university\@empty
	\else
		{\vspace{1cm}\normalsize\centering\@university\par}
	\fi
}

\newcommand{\bottomtitlepage}{
	\ifx\@date\@empty
	\else
		{\hspace{2cm}\raggedright\normalsize Thèse soutenue le \@date}
	\fi
	\ifx\@jury\@empty
	\else
		\ifx\@date\@empty
		{\normalsize\raggedright\hspace{2cm}Jury constitué de\par}
		\else
		{en présence de\par}
		\fi
		\vspace{1ex}
		{\normalsize\centering\begin{tabular}{l@{ }l@{ }c@{ }l@{ }l}
			\@jury
		\end{tabular}\par}
	\vspace{1cm}
	\fi
	\ifx\@signatures\@empty
	\else
		{\normalsize\centering\textbf{signatures}\hspace{\stretch{1}}\@signatures\hspace{\stretch{1}}\par}
	\fi
}

\def\maketitle{%
	\begin{titlepage}
		\null
		\thispagestyle{empty}
		\toptitlepage
		\vfill
		\bodytitlepage
		\vfill
		\bottomtitlepage
		\null
	\end{titlepage}
	\clearpage
}

%% Redéfinition de la mise en page des paragraphes
\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

% Automatic include of mini-bibliographies
\let\oldendmysection\endmysection
\def\endmysection{\myminibiblio\oldendmysection}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fin de la redéfinition des différentes parties %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% En-tête par défaut
\documenttype{}
\author{}
\title{}
\subtitle{}
\university{}
\date{}
\jury{}
\signatures{}
\logoleft{}
\logoright{}
\Version{}
