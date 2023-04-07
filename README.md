# Open Resources for Community College Algebra (ORCCA)
An open textbook for basic and intermediate algebra written with PreTeXt

## Legal Stuff
Copyright Portland Community College.

Open Resources for Community College Algebra is licensed under a
Creative Commons Attribution 4.0 International License.

Under this license, any user of this textbook or its contents must provide
proper attribution as follows. If you redistribute all or part of this textbook,
then you must include in every digital format page view (including but not
limited to EPUB, PDF, and HTML) and on every physical printed page the following
attribution:

Original source material, products with readable and accessible math content,
and other information freely available at pcc.edu/orcca.

The Portland Community College name, Portland Community College logo, ORCCA
name, Open Resources for Community College Algebra name, ORCCA logo, and front
and back cover designs are not subject to the Creative Commons license and may
not be reproduced without the prior and express written consent of Portland
Community College.

(So if you make your own copy of this book, you may not name it "ORCCA", etc.
This helps our students avoid confusion if they find your copy on the internet.)

We can grant individual licenses that don't have some of the Creative Commons
restrictions, but you will need to contact us first. All inquiries can be sent
to orcca-group@pcc.edu.

## Versions
Several versions of this book have been under development since 2016.
View the 2nd edition at
https://spot.pcc.edu/math/orcca/ed2/html/frontmatter.html.

We are currently devleoping the 3rd edition. The content will have revisions,
and there will be more technology features with the HTML copy of the book.

## Build Your Own Copy
If you'd like to build your own copy, you can follow the steps below. Things are set up so that you will only build the first section of the book. You can make adjsutments to build more later. But it takes a lot of time to do a complete build. Also, it will build from edition 3, which is a work in progress. In some steps below, you may see `PTX:ERROR:` a lot, but this is only because large portions of the book are commented out for now.

1. Install (or update) [the PreTeXt CLI](https://github.com/PreTeXtBook/pretext-cli). You will also need a LaTeX installation like TeXLive as mentioned in the "External dependenies" section.

2. Use git to get this `orcca` repository. If you are not sure how to do that, try [this tutorial](https://www.techrepublic.com/article/how-to-clone-github-repository/)

3. On the command line, change diretory to `orcca/`.

4. Run: `pretext generate latex-image` (or as noted on the CLI installation page, maybe `python -m pretext generate latex-image` or `python3 -m pretext generate latex-image`)

5. Run: `pretext generate webwork` (or maybe `python -m pretext generate webwork` or `python3 -m pretext generate webwork`)

6. Run: `pretext build html` (or maybe `python -m pretext build html` or `python3 -m pretext build html`)

7. Run: `pretext build pdf` (or maybe `python -m pretext build pdf` or `python3 -m pretext build pdf`)

8. The output files are in `orcca/output`. A convenient way to view the HTML output is to run `pretext view html`. Use `^C` to end the local web server when you are done.

