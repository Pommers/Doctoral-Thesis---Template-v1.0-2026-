# UTRGV Thesis Template

## Summary

This template is derived from an older UTRGV structured format template for Masters Thesis and PhD Dissertations, but has been updated for the requirements in 2026. 

Additional functionality for previously published manuscripts, including declarations, has also been included as part of the class (.cls) file.

## Quick Start

The main changes you will need to make using this template, will be to amend and personalise the `settings.tex` file (in the `preamble` subfolder). This file includes you name, the title of your thesis or dissertation, and you committee member names.

## Overview

It is split into three main parts
- **main.tex** - this is the main document which structures the contents, and includes features such as the Front matter (title page, copyright, abstract placeholder), Table of Contents, List of Figures, etc. Chapters can be 'input' in order to include them in the document.
- **sections folder** - This is a subfolder which will contain your additional sections, such as the *abstract*, *acknowledgments*, *dedications*, etc. These must be referenced and input in the relevant section of the `main.tex` document (see above). Many of these are optional, depending upon the type of document.
- **chapters folder** - This is a subfolder which will contain all of your chapters. These must be referenced and input in the relevant section of the `main.tex` document (see above), but this is where the meat of your content should be included.
- **preamble folder** - This is just a folder containing files which include useful packages,
\end{itemize}



\section{Chapter declarations}
Use \verb|\chapterpublicationnote| at the start of any chapter based on a published paper.
    \begin{itemize}
        \item #1 = bib key
        \item #2 = reproduced/adapted statement
        \item #3 = licence statement, including link
        \item #4 = licence link or extra copyright note
        \item #5 = contribution statement (optional)
    \end{itemize}
    \eg 
    \begin{verbatim}
    \chapterpublicationnote
        {Pomeroy_2025}
        {This chapter is adapted from the published article.}
        {This article was published under the Creative Commons Attribution 4.0 International (CC BY 4.0) licence:
        https://creativecommons.org/licenses/by/4.0/}
        {The candidate led the analysis, interpretation, figure preparation, and manuscript drafting.}
    \end{verbatim}