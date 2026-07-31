 \NeedsTeXFormat{LaTeX2e}
 \ProvidesClass{UTRGVthesis}[2016/09/01 UTRGV Theses and Dissertations]

% The UTRGVthesis class is for producing theses and dissertations
% that meet the UTRGV requirements.
%
% The following class options are available
%
%   masters   : Produces the masters thesis preliminary pages
%   phd   : Produces the phd dissertation preliminary pages
%   candidacy : Produces the preliminary pages for a PhD candidacy plan
%   noacknowledgments : Removes the acknowledgments page
%   nodedication: Removes the dedication page
%   declaration: Includes a declaration page after the abstract, to detail prepublished works (PrePubA{}, etc.)

% % Boolean to control one-sided vs two-sided layout
% \newif\ifutrgv@twoside
% \utrgv@twosidefalse

% % Custom class option
% \DeclareOption{twoside}{\utrgv@twosidetrue}
% \DeclareOption{oneside}{\utrgv@twosidefalse}

% These packages typeset the thesis with Times Roman font
% \RequirePackage{mathptmx}
\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath}  % for ams mathematical environments
\RequirePackage{amsthm} % for producing theorem-like environments

\RequirePackage{newtxtext,newtxmath}

\RequirePackage[letterpaper]{geometry} % for fixing margins
\RequirePackage{indentfirst}  % for indention of first paragraph
\RequirePackage{graphicx} % Allow the inclusion of graphics
\RequirePackage{setspace} % Allow double spacing with the \doublespacing
\RequirePackage{calc}

\RequirePackage{etoolbox}

% Declare some variables to hold the text fields for the preliminary pages

    \newcommand{\Title}[1]{
      \gdef\UTRGVField@Title{#1}
      \gdef\UTRGVField@UppercaseTitle{\uppercase{#1}}
      \def\UTRGVField@UlineTitle{%
        \def\\{\relax}%
        \protected@edef\tmp{\UTRGVField@Title}%
        \expandafter\uline\expandafter{\tmp}%
      }
    }
    % \newcommand{\AuthorLastFirst}[1]{\gdef\UTRGVField@AuthorLastFirst{#1}}
    % \newcommand{\Author}[1]{
    %   \gdef\UTRGVField@Author{#1}
    %   \gdef\UTRGVField@UppercaseAuthor{\uppercase{#1}}
    % }

    \ExplSyntaxOn
    
    % Stored fields
    \cs_new:Npn \UTRGVField@Author {}
    \cs_new:Npn \UTRGVField@UppercaseAuthor {}
    \cs_new:Npn \UTRGVField@AuthorLastFirst {}
    \cs_new:Npn \UTRGVField@AuthorLastFirstMI {}
    
    % Manual overrides
    \newcommand{\AuthorLastFirst}[1]{\cs_gset:Npn \UTRGVField@AuthorLastFirst {#1}}
    \newcommand{\AuthorLastFirstMI}[1]{\cs_gset:Npn \UTRGVField@AuthorLastFirstMI {#1}}
    
    % Internal scratch variables
    \seq_new:N \l__utrgv_author_seq
    \tl_new:N  \l__utrgv_surname_tl
    \tl_new:N  \l__utrgv_given_tl
    \tl_new:N  \l__utrgv_first_tl
    \tl_new:N  \l__utrgv_rest_tl
    \tl_new:N  \l__utrgv_initials_tl
    
    \cs_new_protected:Npn \utrgv_derive_author_fields:
      {
        \tl_if_blank:eF {\UTRGVField@Author}
          {
            % Split full name at spaces
            \seq_set_split:Nee \l__utrgv_author_seq { ~ } { \UTRGVField@Author }
    
            % Last item = surname
            \seq_pop_right:NN \l__utrgv_author_seq \l__utrgv_surname_tl
    
            % Everything left = given names
            \tl_set:Ne \l__utrgv_given_tl { \seq_use:Nn \l__utrgv_author_seq { ~ } }
    
            % Fill Last, First Middle only if not manually overridden
            \tl_if_blank:eT { \UTRGVField@AuthorLastFirst }
              {
                \cs_gset:Npe \UTRGVField@AuthorLastFirst
                  { \l__utrgv_surname_tl ,~ \l__utrgv_given_tl }
              }
    
            % Fill Last, First M. M. only if not manually overridden
            \tl_if_blank:eT { \UTRGVField@AuthorLastFirstMI }
              {
                % Work on a copy, since we need the full sequence above too
                \seq_set_eq:NN \l_tmpa_seq \l__utrgv_author_seq
                \seq_pop_left:NN \l_tmpa_seq \l__utrgv_first_tl
                \tl_clear:N \l__utrgv_initials_tl
    
                % Remaining given names -> initials
                \seq_map_inline:Nn \l_tmpa_seq
                  {
                    \tl_put_right:Ne \l__utrgv_initials_tl
                      { ~ \tl_head:n {##1}. }
                  }
    
                \cs_gset:Npe \UTRGVField@AuthorLastFirstMI
                  { \l__utrgv_surname_tl ,~ \l__utrgv_first_tl \l__utrgv_initials_tl }
              }
          }
      }
    
    % Canonical field
    \newcommand{\Author}[1]{%
      \cs_gset:Npn \UTRGVField@Author {#1}%
      \cs_gset:Npn \UTRGVField@UppercaseAuthor {\MakeUppercase{#1}}%
      \utrgv_derive_author_fields:%
    }
    
    \ExplSyntaxOff
    
    \newcommand{\docname}[1]{\gdef\UTRGVField@DocName{#1}}
    \newcommand{\degree}[1]{
      \gdef\UTRGVField@Degree{#1}
      \gdef\UTRGVField@UppercaseDegree{\uppercase{#1}}
    }
    \newcommand{\degreestage}[1]{\gdef\UTRGVField@DegreeStage{#1}}
    \newcommand{\degreeabbrev}[1]{\gdef\UTRGVField@DegreeAbbrev{#1}}
    \newcommand{\Advisor}[1]{\gdef\UTRGVField@Advisor{#1}}
    \newcommand{\AdvisorTitle}[1]{\gdef\UTRGVField@AdvisorTitle{#1}}
    \newcommand{\MemberA}[1]{\gdef\UTRGVField@MemberA{#1}}
    \newcommand{\MemberATitle}[1]{\gdef\UTRGVField@MemberATitle{#1}}
    \newcommand{\MemberB}[1]{\gdef\UTRGVField@MemberB{#1}}
    \newcommand{\MemberC}[1]{\gdef\UTRGVField@MemberC{#1}}
    \newcommand{\MemberD}[1]{\gdef\UTRGVField@MemberD{#1}}
    \newcommand{\MemberE}[1]{\gdef\UTRGVField@MemberE{#1}}
    \newcommand{\MemberF}[1]{\gdef\UTRGVField@MemberF{#1}}
    \newcommand{\MemberG}[1]{\gdef\UTRGVField@MemberG{#1}}
    \newcommand{\MemberH}[1]{\gdef\UTRGVField@MemberH{#1}}

    \newcommand{\Month}[1]{\gdef\UTRGVField@Month{#1}}
    \newcommand{\Year}[1]{\gdef\UTRGVField@Year{#1}}
    \newcommand{\Abstract}[1]{\gdef\UTRGVField@Abstract{#1}}
    \newcommand{\Dedication}[1]{\gdef\UTRGVField@Dedication{#1}}
    \newcommand{\Acknowledgments}[1]{\gdef\UTRGVField@Acknowledgments{#1}}
    \newcommand{\BiographicalSketch}[1]{\gdef\UTRGVField@BiographicalSketch{#1}}
    \newcommand{\Major}[1]{\gdef\UTRGVField@Major{#1}}

    \newcommand{\Declaration}[1]{\gdef\UTRGVField@Declaration{#1}}
    \newcommand{\PrePublicationList}[1]{\gdef\UTRGVField@PrePublicationList{#1}}

% Initialize the variables to their default values

    \Title{Titles Must Be in Mixed Case and May Not Exceed Six Inches}
    \docname{Thesis}
    \degree{Master of Science}
    \degreestage{Candidacy}
    \degreeabbrev{(MS)}
    \AdvisorTitle{Chair of Committee}
    \MemberA{}
    \MemberATitle{Committee Member}
    \MemberB{}
    \MemberC{}
    \MemberD{}
    \MemberE{}
    \MemberF{}
    \MemberG{}
    \MemberH{}
    \PrePublicationList{}

% define a command to insert a blank page
    \newcommand{\insertblankpage}{%
      \newpage
      \thispagestyle{empty}
      \mbox{}
    \addtocounter{page}{-1}
      \newpage
    }

% Use to keep track of many pages in TOC, LOT, TOC, abstract, dedication
\newcounter{pagebegin}
\newcounter{pagedifference}

% Define the preliminary page layouts using the variables

    \newcommand{\utrgvtitlepage}{%
        \newgeometry{top=2in, bottom=1in, left=1in, right=1in}
        \thispagestyle{empty}
        {
            \centering
            \doublespacing
            \UTRGVField@UppercaseTitle\par
            % \singlespacing
            \vfill  % provides equal spacing
            A \UTRGVField@DocName \\
            by \\
            \UTRGVField@UppercaseAuthor\\
            \vfill  % provides equal spacing
            % Submitted to the Graduate College of\\
            % The University of Texas Rio Grande Valley\\
            % In partial fulfillment of the requirements for the degree of\\
            Submitted in Partial Fulfillment of the \\
            Requirements for the Degree of \\
            \UTRGVField@UppercaseDegree\\
            \vspace{2\baselineskip}  % skip 2 lines
            Major Subject: \UTRGVField@Major \\
            \vspace{3\baselineskip}  % skip 3 lines
            \singlespacing
            The University of Texas Rio Grande Valley\\\UTRGVField@Month~\UTRGVField@Year\\
        }
      \restoregeometry
        \insertblankpage
        \addtocounter{page}{-1}  % don't increment page counter for this page
      }

    \newcommand{\committeepage}{%
        \newgeometry{top=2in, bottom=1in, left=1in, right=1in}
        \thispagestyle{empty}
        \singlespacing
        {
            \centering
            \doublespacing
            {\UTRGVField@UppercaseTitle}\par
            \singlespacing\par
            A \UTRGVField@DocName \\
            by \\
            \UTRGVField@UppercaseAuthor\\
            \vspace{5\baselineskip}
            % \vfill
            \uppercase{Committee Members} \\
        \vfill
        \UTRGVField@Advisor\\
        \UTRGVField@AdvisorTitle\\
        \vfill
        \if \UTRGVField@MemberA \relax \relax \else \mbox{\UTRGVField@MemberA}\\
                \UTRGVField@MemberATitle \\
                \vfill
        \fi
        \if \UTRGVField@MemberB \relax \relax \else \mbox{\UTRGVField@MemberB}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberC \relax \relax \else \mbox{\UTRGVField@MemberC}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberD \relax \relax \else \mbox{\UTRGVField@MemberD}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberE \relax \relax \else \mbox{\UTRGVField@MemberE}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberF \relax \relax \else \mbox{\UTRGVField@MemberF}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberG \relax \relax \else \mbox{\UTRGVField@MemberG}\\
                Committee Member\\
                \vfill
        \fi
        \if \UTRGVField@MemberH \relax \relax \else \mbox{\UTRGVField@MemberH}\\
                Committee Member\\
                \vfill
        \fi
        \vspace{5\baselineskip}  % 
        \mbox{\UTRGVField@Month~\UTRGVField@Year} \\
        % \vspace{5\baselineskip}  % skip 5 lines to line up with previous page
        % \par
      }
        \restoregeometry
        \insertblankpage
      }

    \newcommand{\copyrightpage}{%
        \newgeometry{top=0in, bottom=0in, left=1in, right=1in}
        \thispagestyle{empty}
        \mbox{}  % empty box
        {\centering%
        \vfill
        \doublespacing
        Copyright~\UTRGVField@Year~\UTRGVField@Author \\
        All Rights Reserved\\
        \vspace{10pt}  % moves up text to center
        \vfill
        \singlespacing
        \par
        }


        \restoregeometry
        \insertblankpage
    }

    \newcommand{\abstractpage}{%
        \setcounter{pagebegin}{\value{page}} %get value of first page
        \newgeometry{top=1in, bottom=1in, left=1in, right=1in}
        \thispagestyle{fancy}
        \phantomsection
        \vspace*{0.625in}%

        {\centering%
        ABSTRACT\\
        % \vspace{\baselineskip}
        \par
        }
        \addcontentsline{toc}{chapter}{Abstract}
        \doublespacing
        {\setlength{\parindent}{0.5in}
          \noindent
          \UTRGVField@AuthorLastFirstMI,
          \UTRGVField@UlineTitle.
          \UTRGVField@Degree~\UTRGVField@DegreeAbbrev,
          \UTRGVField@Month,~\UTRGVField@Year,
          \pageref{LastPage}~pp.,
          \ifnum \totvalue{tablenum}=0
             \relax \relax
          \else
            {\ifnum\totvalue{tablenum}=1  \total{tablenum}~table,\else
              \total{tablenum}~tables,\fi}
          \fi
          \ifnum \totvalue{figurenum}=0
             \relax \relax
          \else
            {\ifnum\totvalue{figurenum}=1 \total{figurenum}~figure,\else
              \total{figurenum}~figures,\fi}
          \fi
          \total{bibnum}~references. 
          %(\total{citedunique}~unique citations, \total{citehits}~total citations, \total{citerepeats}~repeat cites).

        \UTRGVField@Abstract\par
      }

        \vfill

        \restoregeometry
        % keep track of pages
        \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
        \ifodd \value{pagedifference}
          \insertblankpage % insert blank page only if odd number of pages
        \fi
    }

    \RequirePackage{etoolbox}
    
    \newcommand{\declarationfullcite}[1]{%
      \AtNextCite{\defcounter{maxnames}{99}}%
      \fullcite{#1}%
    }
    
    \newcommand{\declarationentry}[1]{%
      \par
      \hangindent=0.5in
      \hangafter=1
      \noindent\declarationfullcite{#1}\par
      % \addvspace{\baselineskip}%
    }
 
    \newcommand{\printdeclarationentries}{%
      \ifstrempty{\UTRGVField@PrePublicationList}
        {}
        {%
            \edef\UTRGVField@templist{\UTRGVField@PrePublicationList}%
            \renewcommand*{\do}[1]{\declarationentry{##1}}%
            \expandafter\docsvlist\expandafter{\UTRGVField@templist}%       
        }%
    }
    
    \newcommand{\declarationpage}{%
        \setcounter{pagebegin}{\value{page}} %get value of first page
        \newgeometry{top=2in, bottom=1in, left=1in, right=1in}
        \thispagestyle{fancy}
        \phantomsection
        {\centering
        \uppercase{Declaration}\\
        \par}
        % \vspace{\baselineskip}
         % \small\normalsize%
        \addcontentsline{toc}{chapter}{Declaration}
        {\setlength{\parindent}{0.5in}
        \doublespacing
        The work in this thesis is based on research carried out at the Department of Physics and Astronomy, University of Texas Rio Grande Valley, USA. No part of this \UTRGVField@DocName\ has been submitted elsewhere for any other degree or qualification and it is all my own work unless referenced to the contrary here or in the text. Some of this work has, however, been published in the following papers (in chronological order):
        \par
        
        \printdeclarationentries
        }
        \restoregeometry
        % keep track of pages
        \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
        \ifodd \value{pagedifference}
          \insertblankpage % insert blank page only if odd number of pages
        \fi

        }

    % Allow opt-out on declaration
    \DeclareOption{nodeclaration}{%
      \renewcommand{\declarationpage}{}
    }

    \newcounter{pseudosection}
    \newcommand{\notasection}[2]{%
        \stepcounter{pseudosection}%
        \par
        % \vspace{0.5\baselineskip}
        \phantomsection
        \pdfbookmark[#1]{#2}{pseudo:\roman{pseudosection}}%
        \begin{center}
            \normalfont \textit{#2}
            \vspace{-0.3em}%
        \end{center}
        \par
        \indent
    }

    % #1 = bib key
    % #2 = reproduced/adapted statement
    % #3 = licence statement, including link
    % #4 = licence link or extra copyright note
    % #5 = contribution statement (optional)
    \newcommand{\chapterpublicationnote}[4]{%
    % \section*{Publication Note}
    % \begin{center}
    %     \normalfont \textit{Publication Note}
    %     \vspace{-0.3em}%
    % \end{center}
    \notasection{1}{Publication Note}
    This chapter is based on material originally published as 
    \declarationfullcite{#1}. 
    #2
    #3
    \ifstrempty{#4}{}{#4}
    \par
    }

    \newcommand{\dedicationpage}{%
      \if \UTRGVField@Dedication
       \relax
      \else
        \setcounter{pagebegin}{\value{page}} %get value of first page
        \newgeometry{top=2in, bottom=1in, left=1in, right=1in}
        \thispagestyle{fancy}
        \phantomsection
        {\centering
        \uppercase{Dedication}\\
        \par}
        % \vspace{\baselineskip}
        \small\normalsize%
        \addcontentsline{toc}{chapter}{Dedication}
        {\setlength{\parindent}{0.5in}
          \doublespacing
        \UTRGVField@Dedication
      }
        \restoregeometry
        % keep track of pages
        \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
        \ifodd \value{pagedifference}
          \insertblankpage % insert blank page only if odd number of pages
        \fi
      \fi
        }


    \newcommand{\biographypage}{%
      \inappendixfalse
      \newgeometry{top=0.85in, bottom=1in, left=1in, right=1in}

      \chapter*{VITA}
        \addcontentsline{toc}{chapter}{Vita}
          \doublespacing
        {\setlength{\parindent}{0.5in}
        \UTRGVField@BiographicalSketch
      }

        \par\renewcommand{\baselinestretch}{1} \small\normalsize%
        \restoregeometry
        }

    \newcommand{\acknowledgmentspage}{%
      \if \UTRGVField@Acknowledgments
       \relax
      \else
        \setcounter{pagebegin}{\value{page}} %get value of first page
        \newgeometry{top=1in, bottom=1in, left=1in, right=1in}

        \vspace*{0.625in}%
        % \begin{center}
        %   \normalfont TABLE OF CONTENTS
        % \end{center}
        
        % \vspace{0.75em}%

        \thispagestyle{fancy}
        \phantomsection
        {\centering
         \uppercase{Acknowledgments}\\
         \par}
        % \vspace{\baselineskip}
        \small\normalsize%
        \addcontentsline{toc}{chapter}{Acknowledgments}
        {\setlength{\parindent}{0.5in}
        \doublespacing
        \UTRGVField@Acknowledgments
      }
        \restoregeometry
        % keep track of pages
        \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
        \ifodd \value{pagedifference}
          \insertblankpage % insert blank page only if odd number of pages
        \fi
      \fi
        }

% Allow opt-out on acknowledgments
    \DeclareOption{noacknowledgments}{%
      \renewcommand{\acknowledgmentspage}{}
    }

% Allow opt-out on dedication
    \DeclareOption{nodedication}{%
      \renewcommand{\dedicationpage}{}
    }


    \DeclareOption{masters}{%
      \degree{Master of Science}
      \degreeabbrev{(MS)}
      \docname{Thesis}
      \AdvisorTitle{Chair of Committee}
    }

    \DeclareOption{phd}{%
      \degree{Doctor of Philosophy}
      \degreeabbrev{(PhD)}
      \docname{Dissertation}
      \AdvisorTitle{Chair}
    }

    \DeclareOption{candidacy}{%
      \degree{Doctor of Philosophy}
      \degreeabbrev{(PhD)}
      \docname{PhD Candidacy Proposal}
      \AdvisorTitle{Chair}
    }
% Define the macro for making preliminary pages
    \newcommand{\makepreliminarypages}{%
      % We insert the pages heres and adjust spacing and geometry
        \utrgvtitlepage
        \committeepage
        \copyrightpage
        \abstractpage
        \declarationpage
        \dedicationpage
        \acknowledgmentspage
        \setlength{\parindent}{0.5in}
        \tableofcontents
        \doublespacing{}
        \listoftables
        \listoffigures
    }
    
    \DeclareOption{candidacy}{%
        \degree{Doctor of Philosophy}
        \degreeabbrev{(PhD)}
        \docname{PhD Candidacy Proposal}
        \AdvisorTitle{Chair}
    % Define the macro for making preliminary pages
        \renewcommand{\makepreliminarypages}{%
          % We insert the pages heres and adjust spacing and geometry
            \utrgvtitlepage
            \committeepage
            % \copyrightpage
            \abstractpage
            % \dedicationpage
            % \acknowledgmentspage
            \setlength{\parindent}{0.5in}
            \tableofcontents
            \doublespacing{}
            % \listoftables
            % \listoffigures
        }
    }


% Load the class and needed packages
    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions
    \relax
    % Load base class according to switch
    % \ifutrgv@twoside
    % \LoadClass[letterpaper,12pt,twoside,openright]{book}
    % \else
     \LoadClass [letterpaper,12pt,oneside]{book}
    % \fi


\renewcommand{\contentsname}{TABLE OF CONTENTS\vspace{-0.20in}}
\renewcommand\listfigurename{LIST OF FIGURES\vspace{-0.20in}}
\renewcommand\listtablename{LIST OF TABLES\vspace{-0.20in}}
\renewcommand{\bibname}{REFERENCES}


% Set the margins to UTRGV specifications

\geometry{top=1in, bottom=1in, left=1in, right=1in}
   \setlength{\parindent}{0.5in}
    \raggedbottom


% Uncomment these to allow allow more liberal figure placement
    \renewcommand{\topfraction}{0.9}
    \renewcommand{\bottomfraction}{0.8}
    \setcounter{topnumber}{2}
    \setcounter{bottomnumber}{2}
    \setcounter{totalnumber}{4}
    \renewcommand{\textfraction}{0.07}


% Redefine the Table of Contents to deal with some blank page
% and bookmarking issues relating to ETD submission
    \let\TEMPtableofcontents\tableofcontents
    \renewcommand{\tableofcontents}{%
      \setcounter{pagebegin}{\value{page}} %get value of first page in TOC
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Table of Contents}
      \singlespacing
      % top margin should be 2inches
      % ToC: first title at 2", continuation pages at 1"
      \newgeometry{top=1in, bottom=1in, left=1in, right=1in}
      \vspace*{0.625in}%
      \begin{center}
        \normalfont TABLE OF CONTENTS
      \end{center}
    
      \vspace{0.75em}%
      \@starttoc{toc}%

      \thispagestyle{fancy}
      \restoregeometry

      % keep track of pages in TOC
      \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
      \ifodd \value{pagedifference}
        \insertblankpage % insert blank page only if odd number of pages
        \fi
    }

 %Redefine the List of Figures to deal with some blank page
 %and bookmarking issues
    \let\TEMPlistoffigures\listoffigures
    \renewcommand{\listoffigures}{%
      \setcounter{pagebegin}{\value{page}} %get value of first page in LOF
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{List of Figures}
      \singlespacing
        \newgeometry{top=1in, bottom=1in, left=1in, right=1in}
      % \TEMPlistoffigures
      % \doublespacing
      \vspace*{0.625in}%
      \begin{center}
        \normalfont LIST OF FIGURES
      \end{center}
    
      \vspace{0.75em}%
      \@starttoc{lof}%

      
        \thispagestyle{fancy}
        \restoregeometry

      % keep track of pages
      \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
      \ifodd \value{pagedifference}
        \insertblankpage % insert blank page only if odd number of pages
      \fi
    }

 %Redefine the List of Tables to deal with some blank page
 %and bookmarking issues
    \let\TEMPlistoftables\listoftables
    \renewcommand{\listoftables}{%
      \setcounter{pagebegin}{\value{page}} %get value of first page in LOT
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{List of Tables}
        \newgeometry{top=1in, bottom=1in, left=1in, right=1in}
      \vspace*{0.625in}%
      \begin{center}
        \normalfont LIST OF TABLES
      \end{center}
    
      \vspace{0.75em}%
      \@starttoc{lot}%

        \thispagestyle{fancy}
        \restoregeometry

      % keep track of pages
      \setcounter{pagedifference}{\value{pagebegin} - \value{page}}
      \ifodd \value{pagedifference}
        \insertblankpage % insert blank page only if odd number of pages
      \fi
    }

 %Redefine the Bibliography to deal with a bookmarking issues
    \let\TEMPbibliography\bibliography
    \renewcommand{\bibliography}{%
      \let\TEMPvspace\vspace
      \renewcommand{\vspace}[1]{\relax}
      \clearpage
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{\bibname}
      \inappendixfalse
      \let\vspace\TEMPvspace
      \TEMPbibliography
    }

% % Define the macro for making preliminary pages
%     \newcommand{\makepreliminarypages}{%
%       % We insert the pages heres and adjust spacing and geometry
%         \utrgvtitlepage
%         \committeepage
%         \copyrightpage
%         \abstractpage
%         \dedicationpage
%         \acknowledgmentspage
%         \setlength{\parindent}{0.5in}
%     }
% \DeclareOption{candidacy}{
% % Define the macro for making preliminary pages
%     \renewcommand{\makepreliminarypages}{%
%       % We insert the pages heres and adjust spacing and geometry
%         \utrgvtitlepage
%         % \committeepage
%         % \copyrightpage
%         \abstractpage
%         % \dedicationpage
%         % \acknowledgmentspage
%         \setlength{\parindent}{0.5in}
%     }
% }



% The fancyhdr package allows you to easily customize the page header.
% The settings below produce a nice, well separated header.
\RequirePackage{fancyhdr}
\fancyhead{}
\renewcommand{\headrulewidth}{0pt}
  \pagestyle{fancy}



%%%% tips from http://texblog.org/2011/09/09/10-ways-to-customize-tocloflot/
%% Control the fonts and formatting used in the table of contents.
\RequirePackage[titles]{tocloft}
\RequirePackage{etoolbox}  % for \patchcmd

\patchcmd{\l@chapter}  % patch command provided by tocloft
  {\cftchapfont #1}%   search pattern
  {\uppercase{#1}}% replace by
  {}%                  success
  {}%                  failure

\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapleader}{\cftdotfill{2.6}} % Add Table of Contents dots


%% Aesthetic spacing redefines that look nicer to me than the defaults.
%% this applies to table of contents
\setlength{\cftbeforechapskip}{1ex}
\setlength{\cftbeforesecskip}{1ex}
\setlength{\cftbeforesubsecskip}{1ex}
\renewcommand\cftfigafterpnum{\vskip5pt\par}
\renewcommand\cfttabafterpnum{\vskip5pt\par}

\addtocontents{toc}{\vspace{\baselineskip}~\hfill{Page}\par\vspace{2mm}}
\addtocontents{lof}{\vspace{\baselineskip}~\hfill{Page}\par\vspace{2mm}}
\addtocontents{lot}{\vspace{\baselineskip}~\hfill{Page}\par\vspace{2mm}}

% These add the words Figure or Table before entries in List of Figures/Tables
\renewcommand{\cftfigfont}{\hspace{-17pt}Figure } % fix margin of lof
\renewcommand{\cfttabfont}{\hspace{-17pt}Table } % fix margin of lot


% These add a colon after entries in List of Figures/Tables
\renewcommand{\cftfigaftersnum}{:}
\renewcommand{\cfttabaftersnum}{:}


\newcommand{\resetchapterspacing}[1]{
  \titlespacing{\chapter}
    {0in} % increases the left margin
    {#1} % vertical space before the title
    {.75\baselineskip} % separation between title and text
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  creates a boolean that indicates whether we are in appendix mode
\newif\ifinappendix

% how many (total) appendix "chapters" we have
\newcounter{appendixchapters}

% value reloaded from the .aux file on subsequent runs
\providecommand{\totalappendixchapters}{0}

% decide what to print on the global front page of appendix / appendices!
\newcommand{\appendixtitle}{%
  \ifnum\totalappendixchapters=1
    APPENDIX%
  \else
    APPENDICES%
  \fi
}

% at the *end* of the document, record how many appendices we saw
\AtEndDocument{%
  \immediate\write\@auxout{%
    \string\gdef\string\totalappendixchapters{\arabic{appendixchapters}}%
  }%
}

\let\TEMPappendix\appendix
\renewcommand{\appendix}{%
  % *** global front page for the appendix block ***
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{empty}%
  \vspace*{\fill}%
  \begin{center}
    % \bfseries\LARGE 
    \appendixtitle
  \end{center}
  \vspace*{\fill}%
  \clearpage

  % the original appendix setup
  \renewcommand\thefigure{\Alph{chapter}.\arabic{figure}}%
  \renewcommand\thetable{\Alph{chapter}.\arabic{table}}%
  \inappendixtrue
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{APPENDIX}%
  \gdef\thechapter{\@Alph\c@chapter}%
}

% \let\TEMPappendix\appendix
% \renewcommand{\appendix}{%
%   \renewcommand\thefigure{\Alph{chapter}.\arabic{figure}}
%   \inappendixtrue
%   \setcounter{chapter}{0}%
%   \setcounter{section}{0}%
%   \gdef\@chapapp{APPENDIX}%
%   \gdef\thechapter{\@Alph\c@chapter}
% }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This macro redefines the \chapter command to
% count figures and tables before the counters are cleared
% http://tex.stackexchange.com/questions/60505/custom-chapter-definition
\renewcommand{\chaptername}{CHAPTER}
%% This was copied and modified from book.cls
\renewcommand\chapter{%
  \addtocounter{tablenum}{\value{table}}
  \addtocounter{figurenum}{\value{figure}}
  \setcounter{figure}{0}
  \setcounter{table}{0}
  % \if@openright\cleardoublepage\else\clearpage\fi
  \clearpage
  \thispagestyle{fancy}%
  \global\@topnum\z@
  \@afterindentfalse
  \ifinappendix % checks to see if appendix
    \preappendix  % inserts appendix prepage
  \fi
  \secdef\@chapter\@schapter
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  creates blank page with the APPENDIX A, B, C... before appendix
\newcounter{appendixtracker}

\newcommand\preappendix{%
  % count this appendix chapter for the global APPENDIX/APPENDICES logic
  \stepcounter{appendixchapters}%
  
  \setcounter{appendixtracker}{\value{chapter}} % captures chapter counter
  \stepcounter{appendixtracker} % uses correct chapter counter before it is set
  \newpage
  \thispagestyle{fancy}%
  \mbox{}  % empty box
  {\centering%
  \vfill
  APPENDIX~\Alph{appendixtracker}
  \vspace{1.25\baselineskip}
  \vfill
  \par
  }
  \newpage
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This was copied and modified from book.cls

\def\@makechapterhead#1{%
  \vspace*{1in}%
  {\parindent \z@ \centering
   \normalfont\bfseries
   CHAPTER~\Roman{chapter}\par\nobreak
   \vskip 20\p@
   #1\par\nobreak
   \vskip 40\p@
  }}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \ifinappendix  %% omits appendix title from TOC
                           \addcontentsline{toc}{chapter}%
                             {APPENDIX~\Alph{chapter}}%
                         \else
                           \addcontentsline{toc}{chapter}%
                             {CHAPTER~\Roman{chapter}.~#1}%
                         \fi
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \@makechapterhead{\uppercase{#2}}%
                    \@afterheading
                    \doublespacing
                    }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This was copied and modified from book.cls
\renewenvironment{thebibliography}[1]
      {
      \doublespacing
      \chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \vspace{-42pt}  % makes space between title and text zero
      \vspace{2\baselineskip}  % add two blank line spaces
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\setstretch{1}
           \settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}%
            }
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this package is used to style the chapter, section, and subsection headings
%\RequirePackage[sc,center,tiny,compact]{titlesec}
\RequirePackage[center,tiny,compact,uppercase]{titlesec}


\titleformat{\chapter}
  [display] % shape
  {\filcenter} % format
  {{\chaptertitlename}~\thechapter} %label
  {0\lineskip} % separation between label and title body
  % {0.75\baselineskip} % separation between label and title body
  {} % code preceding the title body
  [] % code following the title body

\titlespacing*{\chapter}
  {0in} % increases the left margin 
  {0.55in} % the vertical space before the title
  {0.75\lineskip} % the separation between title and text
  % {0.625in} % the vertical space before the title
  % {0.75\baselineskip} % the separation between title and text

\titleformat{\section}[block]
  {\bfseries\filcenter}
  {\arabic{chapter}.\arabic{section}~~}
  {0in}
  {}
  []

\titleformat{\subsection}[block]
  {\normalfont\bfseries}
  {\thesubsection~}{0in}{\bfseries}

% \titleformat{\subsubsection}[block]
%   {\normalfont\bfseries}
%   {}{0in}{\indent}[]
\titleformat{\subsubsection}[runin] % runin keeps the text on the same line as heading.
  {\normalfont\bfseries}
  {}{0pt}
  {}
  [.]  % automatically places a full stop
  
\titlespacing*{\subsubsection}
  {\parindent} % aligns start of heading with the usual par indent
  {0.5\baselineskip}
  {0.5em}  % creates small gap between the full stop and the par text

\titleformat{\paragraph}[runin]
  {\normalfont\bfseries\itshape}
  {}{0in}{\indent}[]

% load more packages
\RequirePackage[normalem]{ulem} % for underlining command \uline
\RequirePackage{totcount} % for citation and reference counts
\RequirePackage{lastpage} % to get the number of pages

\newtotcounter{tablenum}  % counter for counting tables
\newtotcounter{figurenum} % counter for counting figures

\newtotcounter{citesnum} % counter for counting citations
\def\oldcite{} \let\oldcite=\cite
\def\cite{\stepcounter{citesnum}\oldcite}

\newtotcounter{bibnum} % counter for counting titles in bibliography
\def\oldbibitem{} \let\oldbibitem=\bibitem
\def\bibitem{\stepcounter{bibnum}\oldbibitem}


% Change numbering style of chapters to Roman.  Keep Arabic for subsections
\renewcommand\thechapter{\Roman{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\renewcommand\theequation{\arabic{chapter}.\arabic{equation}}
\renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
\renewcommand\thetable{\arabic{chapter}.\arabic{table}}


\newcommand{\margins}{%
  \ifdefined \tikz
    \relax
  \else
    \usepackage{tikz}
  \fi
    \usetikzlibrary{calc}
    \newcommand{\marginguides}{% For a logo drawn with TikZ
    \begin{tikzpicture}[remember picture,overlay,yscale=-1]
        \fill [fill=gray!10,line width=0pt] (0in,11in) rectangle (8.5in, 5.5in);
        \fill [fill=gray!20,line width=0pt] (7.5in,0in) rectangle (8.5in, 11in);
        \fill [fill=gray!20,line width=0pt] (7.5in,0in) rectangle (8.5in, 11in);
        \fill [fill=gray!20,line width=0pt] (0in,0in) rectangle (1in, 11in);
        \fill [fill=gray!30,line width=0pt] (0in,2in) rectangle (8.5in, 1in);
        \fill [fill=gray!30,line width=0pt] (0in,11in) rectangle (8.5in, 10in);
     \end{tikzpicture}%
   }

    \newcommand{\hhbar}[2]{% For a logo drawn with TikZ
    \begin{tikzpicture}[remember picture,overlay,yscale=-1]
      \fill [fill=blue!20,line width=0pt] (0in,##1) rectangle (8.5in,##1 + ##2);
    \end{tikzpicture}%
   }
    \usepackage[all]{background}
    \SetBgPosition{current page.north west}% Select location
    \SetBgOpacity{1.0}% Select opacity
    \SetBgAngle{0.0}% Select roation of logo
    \SetBgScale{1.0}% Select scale factor of logo
    \SetBgContents{%
      \hhbar{156pt}{1cm}%
      \hhbar{200pt}{1cm}%
      \marginguides%
    }%
}

% \makeatletter
% \renewenvironment{thebibliography}[1]
%       {\begingroup
%       \doublespacing
%       \chapter*{\bibname}%
%       \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
%       \vspace{-42pt}  % makes space between title and text zero
%       \vspace{2\baselineskip}  % add two blank line spaces
%       \list{\@biblabel{\@arabic\c@enumiv}}%
%            {\setstretch{1}
%            \settowidth\labelwidth{\@biblabel{#1}}%
%             \leftmargin\labelwidth
%             \advance\leftmargin\labelsep
%             \@openbib@code
%             \usecounter{enumiv}%
%             \let\p@enumiv\@empty
%             \renewcommand\theenumiv{\@arabic\c@enumiv}%
%             }
%       \sloppy
%       \clubpenalty4000
%       \@clubpenalty \clubpenalty
%       \widowpenalty4000%
%       \sfcode`\.\@m}
%      {\def\@noitemerr
%        {\@latex@warning{Empty `thebibliography' environment}}%
%       \endlist\endgroup}
% \makeatother

% Use caption package to set caption fonts for tables and figures
\RequirePackage{caption}

\captionsetup[table]{font={small},labelfont={bf}, justification=justified}
\captionsetup[figure]{font={small},labelfont={bf}, justification=justified}

\AtBeginEnvironment{table}{\small} % or \footnotesize, \scriptsize, etc.
\AtBeginEnvironment{tabular}{\small}
\AtBeginEnvironment{longtable}{\small}
\AtBeginEnvironment{tabularx}{\small}
