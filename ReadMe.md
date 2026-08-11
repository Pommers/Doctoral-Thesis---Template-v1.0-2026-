# UTRGV Thesis Template

## Summary

This template is derived from an earlier UTRGV structured-format template for Master's theses and Ph.D. dissertations and has been updated to reflect UTRGV formatting requirements used in 2026.

Additional functionality is included for dissertation chapters based on previously published or submitted manuscripts, including chapter declarations and author-contribution statements.

> **Important:** University formatting requirements may change. This template 
> is intended to assist with document preparation, but students remain
> responsible for checking the current UTRGV Graduate College requirements
> before submission.

## Quick Start

Most users should only need to modify a small number of files.

1. Edit `preamble/settings.tex` to enter:
   - your name;
   - degree and major;
   - graduation month and year;
   - dissertation or thesis title;
   - advisor and committee members;
   - details of any published or submitted manuscripts included as chapters.

2. Replace the example material in the `frontmatter/` directory with your own abstract, acknowledgments, dedication, and biographical material as appropriate.

3. Replace or add chapter files in the `chapters/` directory.

4. Add the chapter files to `main.tex` in the order in which they should appear.

5. Replace the example bibliography, acronym, and glossary entries with those required for your own document.

6. Compile `main.tex`.

The supplied files contain example content and comments showing how the template-specific features are used. Example material should be removed or replaced before submission.

## Project Structure

The template is divided into several main components:

- **`main.tex`**  
  The main document. This controls the overall structure of the thesis or dissertation, including front matter, contents pages, chapters, bibliography, and appendices.

- **`frontmatter/`**  
  Contains front-matter material such as the abstract, acknowledgments, dedication, and biographical section. Some of these components are optional depending on the document and current Graduate College requirements.

- **`chapters/`**  
  Contains the main dissertation or thesis chapters. Chapter files are included from `main.tex`.

- **`appendices/`**  
  Contains supplementary material included after the main dissertation chapters.

- **`preamble/`**  
  Contains document configuration, metadata, packages, macros, bibliography information, and acronym/glossary definitions.

- **`figures/`**  
  Recommended location for figures used throughout the document. Additional subdirectories may be created for individual chapters if useful.

- **`UTRGVthesis.cls`**  
  Defines the institutional document formatting and template-specific commands. Most users should not need to edit this file.

## Common Tasks

### Changing personal and dissertation information

Edit:

```text
preamble/settings.tex
```

This file contains the metadata used to construct the title page and other front-matter elements.

### Adding chapters

Create or copy a chapter file in `chapters/`, then include it at the appropriate location in `main.tex`.

For example:

```latex
\input{chapters/02-example-chapter}
```

The supplied chapter files demonstrate conventional research chapters, manuscript-based chapters, discussion/synthesis, and conclusions. Their structure is illustrative rather than mandatory and should be adapted to the requirements of the research and discipline.

### Published or submitted manuscript chapters

The template includes commands for identifying chapters that are based on published, accepted, or submitted manuscripts and for providing relevant publication and author-contribution information.

Publication metadata should be entered in `preamble/settings.tex`, with the corresponding declaration used at the beginning of the appropriate chapter.

The examples supplied with the template illustrate the expected syntax.

Students should also confirm any publisher requirements concerning reuse, copyright, licensing, or attribution before reproducing published material.

### Bibliography

Bibliographic references are stored in the supplied `.bib` file. 

The template includes fictitious example references to demonstrate the required BibTeX syntax. These should be replaced with the references used in the dissertation.

### Acronyms and Glossary

Acronyms, abbreviations, glossary entries, and linked abbreviation–glossary definitions are configured in:

```text
preamble/acronyms-glossary.tex
```

The template can automatically group acronym entries into user-defined categories.

Detailed instructions and examples are provided in
[`documentation/acronyms-and-glossary.md`](documentation/acronyms-and-glossary.md).

Most users should not need to modify the underlying glossary macros.

## Template-Specific Files

The template contains both content files and files that control formatting.

As a general rule:

**Normally edit:**
- `main.tex`
- `preamble/settings.tex`
- chapter files
- front-matter files
- bibliography entries
- acronym and glossary definitions

**Edit only if required:**
- package configuration
- user-defined macros and commands

**Normally leave unchanged:**
- `UTRGVthesis.cls`
- internal template formatting commands

Changes to the class file may affect institutional formatting throughout the document.

## Documentation

Additional documentation for template-specific features is provided in the `documentation/` directory.

Current guides include:

- Detailed instructions and examples are provided in
[`acronyms-and-glossary.md`](documentation/acronyms-and-glossary.md). — acronym and glossary definitions, categories, linked entries, and usage.

Further documentation may be added for features that require more explanation than is appropriate in this README.

## Before Submission

Before producing the final PDF, check that:

- all example and placeholder content has been removed;
- personal, degree, and committee information is correct;
- chapter titles and numbering are correct;
- all figures, tables, references, acronyms, and glossary entries are present;
- published-material declarations are complete where required;
- the Table of Contents, List of Figures, and List of Tables are current;
- no unresolved LaTeX references or citations remain;
- the final PDF has been checked against the current UTRGV Graduate College
  formatting requirements.

The formatting implemented by this template reflects the requirements used when the template was prepared. It should not be treated as a substitute for the current official university guidance.

