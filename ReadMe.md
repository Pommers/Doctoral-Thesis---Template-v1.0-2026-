# UTRGV Thesis Template

## Summary

This template is derived from an older UTRGV structured format template for Masters Thesis and PhD Dissertations, but has been updated for the requirements in 2026. 

Additional functionality for previously published manuscripts, including declarations, has also been included as part of the class (.cls) file.

## Quick Start

The main changes you will need to make using this template, will be to amend and personalise the `settings.tex` file (in the `preamble` subfolder). This file includes your name, the title of your thesis or dissertation, and you committee member names. If you have any prepublished works you are including as chapters, these can also be defined in the `settings.tex` file.

## Overview

It is split into three main parts
- **main.tex** - this is the main document which structures the contents, and includes features such as the Front matter (title page, copyright, abstract placeholder), Table of Contents, List of Figures, etc. Chapters can be 'input' in order to include them in the document.
- **sections folder** - This is a subfolder which will contain your additional sections, such as the *abstract*, *acknowledgments*, *dedications*, etc. These must be referenced and input in the relevant section of the `main.tex` document (see above). Many of these are optional, depending upon the type of document.
- **chapters folder** - This is a subfolder which will contain all of your chapters. These must be referenced and input in the relevant section of the `main.tex` document (see above), but this is where the meat of your content should be included.
- **preamble folder** - This is just a folder containing files which include useful packages,

## Acronyms and Glossary

The file `acronyms-glossary.tex` contains the configuration and example
definitions for the dissertation acronym and glossary system.

It is designed so that most users should only need to edit this single file.
The template supports abbreviation/acronym entries, standalone glossary
entries, linked abbreviation–glossary pairs, and multiple acronym categories
that are printed automatically in separate sections.

### Acronym categories

Acronym categories are declared near the top of `acronyms-glossary.tex`
using:

```latex
\DeclareAcronymType
    {internal-name}
    {log-extension}
    {output-extension}
    {input-extension}
    {Printed Section Title}
```

For example:

```latex
\DeclareAcronymType
    {phystype}
    {phl}
    {pho}
    {phg}
    {Physical Quantities and Concepts}
```

The template currently defines categories for:

- Physical Quantities and Concepts
- Statistics and Mathematics
- Computation and Analysis
- Scientific Organizations and Facilities
- Miscellaneous

The internal type name, such as `phystype`, is used when defining an
abbreviation:

```latex
\newabbreviation[type=phystype]{emf}{EMF}{electromotive force}
```

The printed acronym sections are generated automatically from the declared
types. Therefore, if a category is added, removed, or renamed using
`\DeclareAcronymType`, there is no separate list of acronym sections that
must also be edited.

The three file extensions associated with each category must be unique. Their
particular names are otherwise unimportant; the supplied examples use
mnemonic three-letter extensions.

### Abbreviations and acronyms

An abbreviation without a corresponding glossary definition may be added
using:

```latex
\newabbreviation[type=stattype]{pca}{PCA}{principal component analysis}
```

The three principal arguments are:

```text
{label}{short form}{long form}
```

The `label` is the internal LaTeX identifier and is used when referring to
the abbreviation in the dissertation.

For example:

```latex
\gls{pca}
```

On first use, the glossary package normally prints the expanded form and
abbreviation; subsequent uses print the abbreviated form according to the
configured glossary style.

### Glossary entries

A term that does not require an abbreviation may be defined using
`\newglossaryentry`:

```latex
\newglossaryentry{calibration}{%
    name={calibration},
    description={%
        The process of establishing the relationship between the output of an
        instrument or measurement system and known reference values.
    }%
}
```

It can then be referenced in the dissertation with:

```latex
\gls{calibration}
```

Glossary entries may also refer to one another where useful.

### Linked abbreviation and glossary entries

Some terms are useful both as abbreviations and as more detailed glossary
entries. For these cases, the template provides the custom command
`\newabbrglspair`.

For example:

```latex
\newabbrglspair[type=stattype]
    {pdf}
    {PDF}
    {probability density function}
    {probability-density-function}
    {%
        A function describing the relative likelihood that a continuous
        random variable takes a particular value.
    }
    {}{}
```

The arguments are:

```text
[type=...]
{abbreviation label}
{short form}
{long form}
{glossary label}
{glossary description}
{short-form plural}
{long-form / glossary plural}
```

The final two plural arguments may be left empty when the default plural forms
are appropriate.

For terms with irregular or otherwise non-standard plurals, supply the plural
forms explicitly. For example:

```latex
\newabbrglspair[type=stattype]
    {dof}
    {DOF}
    {degree of freedom}
    {degree-of-freedom}
    {%
        An independent quantity or parameter that may vary within a physical
        or statistical system.
    }
    {DOFs}
    {degrees of freedom}
```

The paired definition automatically creates both the abbreviation and the
corresponding glossary entry and provides links between the two.

### Using entries in the dissertation

The most commonly used glossary commands are:

```latex
\gls{label}      % normal use
\Gls{label}      % capitalized form
\glspl{label}    % plural form
\Glspl{label}    % capitalized plural form
```

For abbreviation entries, the template also supports the commands provided by
`glossaries-extra`, such as:

```latex
\glsxtrshort{label}
\glsxtrlong{label}
\glsxtrfull{label}
```

Use glossary commands rather than typing abbreviations manually wherever
possible. This allows first-use expansion, pluralization, hyperlinks, and the
printed acronym and glossary lists to remain consistent.

### Adding or changing categories

To create a new acronym category:

1. Add a new `\DeclareAcronymType` declaration near the top of
   `acronyms-glossary.tex`.
2. Give the new type a unique internal name and unique file extensions.
3. Use that internal type name in new `\newabbreviation` or
   `\newabbrglspair` entries.

No changes are required in the acronym appendix. Registered categories are
printed automatically.

### Removing the example entries

The entries supplied with the template are illustrative only. They may be
edited, replaced, or deleted as required.

Before submitting the dissertation, remove any unused example terms and
confirm that all abbreviations and glossary definitions correspond to the
actual content of the dissertation.
