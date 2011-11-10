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
\newif\if@myreview \@myreviewfalse
\DeclareOption{myreview}{\@myreviewtrue}

\ProcessOptions
\PassOptionsToClass{fleqn}{book}
\PassOptionsToClass{12pt}{book}
\PassOptionsToClass{a4paper}{book}
\PassOptionsToClass{twoside}{book}
\LoadClass{book}

\if@myenglish
	\PassOptionsToPackage{english}{babel}
	\PassOptionsToPackage{myenglish}{myref}
\fi
\if@myfrancais
	\PassOptionsToPackage{frenchb}{babel}
	\PassOptionsToPackage{myfrancais}{myref}
\fi
\PassOptionsToPackage{sorting=nyt,hyperref=auto,backend=biber,style=authoryear,citestyle=authoryear-comp,bibstyle=authoryear,abbreviate=false,date=long,urldate=long,block=space,maxcitenames=2,maxbibnames=99}{biblatex}

%% Packages to call
% About characters encoding
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
% To improve the 'enumerate', 'itemize' and 'description' environment
\RequirePackage{enumitem}
% About colors
\RequirePackage{xcolor}
% About numbering the lines
\if@myreview
	\RequirePackage{lineno}
\fi
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
\RequirePackage[biblatex,backref]{mybib}
% All about making references
\RequirePackage[smartref]{myref}

%%%%%%%%%%%%%%%%%%%%
%% Configurations %%
%%%%%%%%%%%%%%%%%%%%
% Substitute Computer Modern to Latin Modern for bold small caps
\DeclareFontSubstitution{T1}{cmr}{bx}{sc}
% About numbering the lines
\if@myreview
	\modulolinenumbers[5]
	\AfterEndPreamble{%
		\pagewiselinenumbers%
		\realpagewiselinenumbers%
	}
\fi
%%% hyperref %%%
% Configuration of hyperref package
\hypersetup{%
	breaklinks=true,%
	citecolor=green,%
	colorlinks=true,%
	filecolor=magenta,%
	hypertexnames=true,%
	linkcolor=gray,%
	naturalnames=true,%
	nesting=false,% Does not compile with 'true'
	pageanchor=true,%
	pdfnewwindow=true,%
	pdfcenterwindow=true,%
	pdfdisplaydoctitle=true,%
	pdffitwindow=true,%
	pdfhighlight=/I,%
	pdfnonfullscreenpagemode=UseOutlines,%
	pdfpagelabels=true,%
	pdfpagelayout=OneColumn,%
	pdfpagemode=UseOutlines,%
	pdfstartview={FitH},%
	%pdfview={FitB},% Should not be used to have correct links
	unicode=true,%
	urlcolor=red%
}%
% Configuration of bookmark package
\bookmarksetup{%
	open=true,%
	openlevel=0,%
	numbered=true,%
	page=1,%
	view={FitH}
}
% To have a dot instead of a comma in numbers for French document
% In scientific documents, dot is better than comma
\if@myfrancais
	\npdecimalsign{.}
\fi

%%% biblatex %%%
% To avoid a semi-colon for 'In Proceeedings...' (instead of 'In: Proceedings...').
\renewcommand{\intitlepunct}{\space}
% To separate each entry in the bibliography with a vertical space
\setlength{\bibparsep}{1ex plus 0.5ex minus 0.2ex}
% Define the 'bibintoc' heading of 'biblatex'
\defbibheading{bibintoc}[\bibname]{%
	\phantomsection%
	\chapter*{#1}%
	\addcontentsline{toc}{chapter}{#1}%
	\markboth{#1}{#1}%
}

%% Declare all options
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\logoleft}[1]{\def\@logoleft{#1}}
\newcommand{\logoright}[1]{\def\@logoright{#1}}
\newcommand{\documenttype}[1]{\def\@documenttype{#1}}
\newcommand{\university}[1]{\def\@university{#1}}
\newcommand{\jury}[1]{\def\@jury{#1}}
\def\jurymember#1#2{%
	\@ifnextchar[{\jurymember@i{#1}{#2}}{\jurymember@i{#1}{#2}[]}%
}
\def\jurymember@i#1#2[#3]#4#5#6{%
	#1 & #2~\myname[#3]{#4} & (#5) \\[-0.67ex]%
	\multicolumn{3}{l}{%
		\hspace{0.33\textwidth}%
		\setlength{\parskip}{0.25ex plus 0.5ex minus 0.2ex}%
		\begin{minipage}[t]{0.73\textwidth}%
			\footnotesize\textcolor{black!70}{#6}%
		\end{minipage}%
		\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}%
	} \\%
}
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
		{\normalsize\centering\begin{mytabular}{>{\hsize=0.3\textwidth}R>{\hsize=0.5\textwidth}L>{\hsize=0.2\textwidth}R}
			\@jury
		\end{mytabular}\par}
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
\def\@makechapterhead#1{%
	\addtocontents{tcs}{\protect\addvspace{10\p@}}%
	\addtocontents{tdo}{\protect\addvspace{10\p@}}%
	\vspace*{50\p@}%
	{\parindent \z@ \raggedleft \normalfont%
	\ifnum \c@secnumdepth >\m@ne%
	\psset{unit=1cm}%
	\begin{pspicture}(-6,-1)(1,1.5)%
		\psframe[linewidth=0,linecolor=myred,fillstyle=solid,fillcolor=myred](-5,-1)(0,0)%
		\psframe[linewidth=0,framearc=.25,linecolor=myred,fillstyle=solid,fillcolor=myred](-1,-1)(1,1)%
		\psframe[linewidth=0,framearc=.25,linecolor=white,fillstyle=solid,fillcolor=white](-6,-0.95)(-1,1)%
		\uput[45](-5,-1){\large\bfseries\sffamily\textcolor{myred}{\@chapapp}}%
		\rput(0,0){\psscaleboxto(1.5,1.5){\white\selectfont\bfseries\sffamily\thechapter}}%
	\end{pspicture}%
	\par\nobreak%
	\fi%
	\interlinepenalty\@M%
	\Huge\bfseries\sffamily #1\par\nobreak%
	\vskip 40\p@%
	}%
}

%% Redéfinition de la mise en page des paragraphes
\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}
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
