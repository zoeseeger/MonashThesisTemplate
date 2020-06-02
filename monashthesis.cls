%% monashthesis Class for LaTeX2e.
%% Version 5.0
%% By Rob J. Hyndman.
%% 28 March 2018
%% Edited by Zoe L. Seeger
%% 1 June 2020
%%
%% This class file is for honours and postgraduate research students
%% in the Faculty of Science
%% at Monash University, Australia.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{monashthesis}[2020/01/06 Monash Thesis Class]

\usepackage[table]{xcolor}
\usepackage{pdfpages} % To include pdfs
\usepackage[export]{adjustbox} % Can align images left or right
\usepackage{float} % Allow extra settings on float positions
\usepackage{makecell} % Split table cells into multiple rows

%% FONT
\usepackage[T1]{fontenc}
\RequirePackage{bera}
\RequirePackage{mathpazo}

\newif\ifsinglesp@
\newif\ifdoublesp@
\newif\ifsingleside@
\doublesp@true
\singleside@false
\DeclareOption{singleside}{\singleside@true}
\DeclareOption{doubleside}{\singleside@false}
\DeclareOption{singlespace}{\singlesp@true}
\DeclareOption{doublespace}{\doublesp@true}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions

\ifsingleside@%
  \LoadClass[a4paper,oneside,openany,draft,11pt]{report}
\else%
  \LoadClass[a4paper,11pt,openright,twoside]{report}
\fi%

%% Page dimensions
\ifsingleside@%
  \usepackage[a4paper,left=3.5cm,right=2.5cm,top=2.5cm,bottom=3.5cm]{geometry}
\else%
  \usepackage[a4paper,left=3.5cm,right=2.5cm,top=2.5cm,bottom=3.5cm,twoside]{geometry}
\fi%

%% CAPTIONS
\RequirePackage{caption}
\DeclareCaptionStyle{italic}[justification=centering]
 {labelfont={bf},textfont={it},labelsep=colon}
\captionsetup[figure]{style=italic,format=hang,singlelinecheck=true}
\captionsetup[table]{style=italic,format=hang,singlelinecheck=true}

%% HEADERS AND FOOTERS
\RequirePackage{fancyhdr}
\pagestyle{fancy}{ % DEFAULT
   \fancyhf{}
   \rfoot{\large\rm\raisebox{-0.1cm}{\textbf{\thepage}}}
   \lhead{\rm{\leftmark}}
   \rhead{}
   \cfoot{}
   \setlength{\headheight}{15pt}
   \renewcommand{\headrulewidth}{0.5pt}
   \renewcommand{\footrulewidth}{0.5pt}}

\fancypagestyle{plain}{% PLAIN USED FOR CHAPTER PAGES
   \fancyhf{}
   \fancyfoot[C]{\rm\textbf{\thepage}}
   \renewcommand{\headrulewidth}{0pt}
   \renewcommand{\footrulewidth}{0pt}}

\fancypagestyle{pubs_head}{% PUBLICATIONS HEADER
   \fancyhf{}
   \setlength{\headheight}{25pt}
   \lhead{\textrm\rm{\rightmark}}
   \fancyhead[R]{\rm\textbf{\thepage}}
   \renewcommand{\headrulewidth}{0.5pt}
   \renewcommand{\footrulewidth}{0pt}}

 \fancypagestyle{pubs_foot}{% PUBLICATIONS FOOTER
    \fancyhf{}
    \lfoot{\textrm\rm{\rightmark}}
    \fancyfoot[R]{\rm\textbf{\thepage}}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0.5pt}}

%% MATHS
\RequirePackage{bm,amsmath}
\allowdisplaybreaks

%% GRAPHICS
\RequirePackage{graphicx}
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.85}
\renewcommand{\textfraction}{0.15}
\renewcommand{\floatpagefraction}{0.7}

\RequirePackage[section]{placeins}

%% SECTION TITLES
\RequirePackage[compact,rm,bf]{titlesec}     % rm: serif font
\titleformat{\section}[block]
  {\fontsize{15}{17}\bfseries\rmfamily}
  {\thesection}
  {0.4em}{}
\titleformat{\subsection}[block]
  {\fontsize{12}{14}\bfseries\rmfamily}
  {\thesubsection}
  {0.4em}{}
\titlespacing{\section}{0pt}{*2}{*0.2}
\titlespacing{\subsubsection}{0pt}{1ex}{0ex}
\titleformat{\subsubsection}{\bf}{}{0ex}{}


%% SPACING
\RequirePackage{setspace}
\spacing{1.5}

%% LINE AND PAGE BREAKING
\sloppy
\clubpenalty = 10000
\widowpenalty = 10000
\brokenpenalty = 10000
\RequirePackage{microtype}
\RequirePackage{ragged2e}

% BIBLIOGRAPHY
\usepackage[
   style=numeric-comp, % https://www.overleaf.com/learn/latex/Biblatex_citation_styles
   backend=biber,          % instead of bibtex
   natbib=true,            % natbib compatibility mode
   sorting=none,           % in order of appearance
   autocite=superscript,   % superscripted by default
   refsection=chapter,     % references at end of each chapter
   maxbibnames=99,         % default: 3, et al.
   isbn=false,             % remove issn
   url=false,              % remove url
   language=auto
]{biblatex}

\AtEveryBibitem{%
  \clearname{translator}
  \clearfield{pagetotal}
  \clearfield{urlyear}
  \clearfield{urlmonth}
  \clearlist{language}
  \clearlist{publisher}
}

\DeclareFieldFormat{url}{\url{#1}}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat[inproceedings]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[incollection]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[article]{volume}{\mkbibbold{#1}}
\DeclareFieldFormat[article]{number}{\mkbibparens{#1}}
\DeclareFieldFormat[article]{title}{\MakeCapital{#1}}
\DeclareFieldFormat[article]{url}{}
%\DeclareFieldFormat[book]{url}{}
%\DeclareFieldFormat[inbook]{url}{}
%\DeclareFieldFormat[incollection]{url}{}
%\DeclareFieldFormat[inproceedings]{url}{}
\DeclareFieldFormat[inproceedings]{title}{#1}
\DeclareFieldFormat{shorthandwidth}{#1}
%\DeclareFieldFormat{extrayear}{}
% No dot before number of articles
\usepackage{xpatch}
\xpatchbibmacro{volume+number+eid}{\setunit*{\adddot}}{}{}{}
% Remove In: for an article.
\renewbibmacro{in:}{%
  \ifentrytype{article}{}{%
  \printtext{\bibstring{in}\intitlepunct}}}

\AtEveryBibitem{\clearfield{month}}
\AtEveryCitekey{\clearfield{month}}

\DeclareDelimFormat[cbx@textcite]{nameyeardelim}{\addspace}

%% PARAGRAPH BREAKS
\setlength{\parskip}{1.4ex}
\setlength{\parindent}{0em}

%% HYPERLINKS
%\RequirePackage[svgnames]{xcolor} % Required for colour specification
\definecolor{darkblue}{rgb}{0,0,.6}
\RequirePackage{url}
\RequirePackage[citecolor=0 0 0,colorlinks=false]{hyperref}
\hypersetup{
     breaklinks=true,
     bookmarksopen=true,
     bookmarksnumbered=true,
     linkcolor=darkblue,
     urlcolor=blue,
     citecolor=darkblue,
     colorlinks=true}

%% LINE SPACING
\AtBeginDocument{%
\ifsinglesp@%
  \singlespacing%
\else%
  \doublespacing%
\fi%
}

%%% TITLE PAGE
\def\degreetitle{Degree not specified}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\degrees#1{\gdef\@degrees{#1}}
\def\studentid#1{\gdef\@degrees{#1}}
\def\@title{}\def\@author{}\def\@supervisor1{}
\def\authorname{\@author}
\def\@degrees{}
\def\@submitdate{\number\the\year}

\RequirePackage{fourier-otf} % TITLE FONTS
\newfontfamily\submittedfont{QTOldGoudy}
\definecolor{title_light_grey}{RGB}{211,211,211} % TITLE COLOURS
\definecolor{title_dark_grey}{RGB}{135, 135, 135}

\usepackage{dashrule} % TITLE DOTTED LINE
\usepackage{tikz}
\usetikzlibrary{decorations.markings}
\newcommand{\dhorline}[3][0]{%
    \tikz[baseline]{\path[decoration={markings,
      mark=between positions 0 and 1 step 2*#3
      with {\node[fill, circle, minimum width=#3, inner sep=0pt, anchor=south west] {};}},postaction={decorate}]  (0,#1) -- ++(#2,0);}}



\def\titlepage{{ % TITLE PAGE MACRO

   \thispagestyle{empty}
  	\centering
  	\textcolor{black}{\rule{\textwidth}{0.4pt}}

  	\vspace{0.01pt}\vspace{-1.05\baselineskip}

   %\dhorline{\textwidth}{1pt} % dotted line
  	\vspace{0.05\textheight} % Whitespace under line
  	\includegraphics[width=15cm]{figures/monash-logo} % Logo
  	\vspace{1cm}

  	\textcolor{black}{{\Large\submittedfont{{\@title}}} % Title
  	\\[0.5\baselineskip]} \vspace{0.025\textheight}
   \vfill
  	\textcolor{title_light_grey}{\rule{0.2\textwidth}{0.4pt}} % Rule

   \vfill
  	{\Large\submittedfont\textsc{%\MakeUppercase
  	{\@author}
  	}}\\ % Author name
   \vfill

  	\textcolor{title_light_grey}{\rule{0.2\textwidth}{0.4pt}}
  	\vfill

  	\begin{center}
  	  {\large\submittedfont\mdseries
  	  {\school} \\ % School
  	  {\faculty} \\ % Faculty
  	  }\vfill
  	  \submittedfont{\itshape{
        A thesis submitted for the degree of \degreetitle { }at\\
        Monash University in \@submitdate}}
   \end{center}

   \vspace{1cm}

  	\vspace{1pt}\vspace{-1.05\baselineskip}
  	\textcolor{black}{\rule{\textwidth}{0.4pt}}
   \newpage\mbox{}\thispagestyle{empty}\newpage
}}

%%% NUMBER WITHIN EACH CHAPTER
\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}

%%% TABLE OF CONTENTS
\setcounter{tocdepth}{1}

\def\prefacesection#1{%
    \chapter*{#1}
%    \addcontentsline{toc}{chapter}{#1}
    \markboth{#1}{#1}}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\def\tighttoc
    {
        \dimen100 = \parskip
        \setlength{\parskip}{0pt}
        \tableofcontents
        \setlength{\parskip}{\dimen100}
    }

% to display the bibliography in table of contents
\usepackage[nottoc,notlot,notlof]{tocbibind}
\usepackage{tocloft}
\renewcommand{\cftchappagefont}{\rmfamily\bfseries}
\renewcommand{\cftchapfont}{\rmfamily\bfseries}
\renewcommand{\cftsecpagefont}{\rmfamily}
\renewcommand{\cftsubsecpagefont}{\rmfamily}
\renewcommand{\cftsecfont}{\rmfamily}
\renewcommand{\cftsubsecfont}{\rmfamily}
\renewcommand{\cfttoctitlefont}{\fontsize{24}{28}\rmfamily\bfseries}

% remove numbering of parts so not in toc
\renewcommand\thepart{}
% remove part number from part page
\renewcommand{\partname}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra stuff for Rmarkdown to work
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
\usepackage{framed}
\definecolor{shadecolor}{RGB}{248,248,248}
\newenvironment{Shaded}{\begin{snugshade}}{\end{snugshade}}
\usepackage{fancyvrb}
\newcommand{\VerbBar}{|}
\newcommand{\VERB}{\Verb[commandchars=\\\{\}]}
\DefineVerbatimEnvironment{verbatim}{Verbatim}{xleftmargin=0em}
\DefineVerbatimEnvironment{Highlighting}{Verbatim}{xleftmargin=0em,commandchars=\\\{\}}

\newcommand{\KeywordTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{\textbf{{#1}}}}
\newcommand{\DataTypeTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{{#1}}}
\newcommand{\DecValTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{{#1}}}
\newcommand{\BaseNTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{{#1}}}
\newcommand{\FloatTok}[1]{\textcolor[rgb]{0.00,0.00,0.81}{{#1}}}
\newcommand{\ConstantTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{{#1}}}
\newcommand{\CharTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{{#1}}}
\newcommand{\SpecialCharTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{{#1}}}
\newcommand{\StringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{{#1}}}
\newcommand{\VerbatimStringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{{#1}}}
\newcommand{\SpecialStringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{{#1}}}
\newcommand{\ImportTok}[1]{{#1}}
\newcommand{\CommentTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textit{{#1}}}}
\newcommand{\DocumentationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{{#1}}}}}
\newcommand{\AnnotationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{{#1}}}}}
\newcommand{\CommentVarTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{{#1}}}}}
\newcommand{\OtherTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{{#1}}}
\newcommand{\FunctionTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{{#1}}}
\newcommand{\VariableTok}[1]{\textcolor[rgb]{0.00,0.00,0.00}{{#1}}}
\newcommand{\ControlFlowTok}[1]{\textcolor[rgb]{0.13,0.29,0.53}{\textbf{{#1}}}}
\newcommand{\OperatorTok}[1]{\textcolor[rgb]{0.81,0.36,0.00}{\textbf{{#1}}}}
\newcommand{\BuiltInTok}[1]{{#1}}
\newcommand{\ExtensionTok}[1]{{#1}}
\newcommand{\PreprocessorTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textit{{#1}}}}
\newcommand{\AttributeTok}[1]{\textcolor[rgb]{0.77,0.63,0.00}{{#1}}}
\newcommand{\RegionMarkerTok}[1]{{#1}}
\newcommand{\InformationTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{{#1}}}}}
\newcommand{\WarningTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textbf{\textit{{#1}}}}}
\newcommand{\AlertTok}[1]{\textcolor[rgb]{0.94,0.16,0.16}{{#1}}}
\newcommand{\ErrorTok}[1]{\textcolor[rgb]{0.64,0.00,0.00}{\textbf{{#1}}}}
\newcommand{\NormalTok}[1]{{#1}}

\usepackage{longtable,booktabs}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\raggedbottom
