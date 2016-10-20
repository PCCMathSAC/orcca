#!/bin/bash
# 
# A file to make module1.pdf, module2.pdf, ..., module10.pdf
#
#   February 3rd 2012
#
# see this
#
# http://tex.stackexchange.com/questions/31334/how-to-create-individual-chapter-pdfs

# pdflatex "\def\myfile{module4,module3} \input{mainfile.tex}"

ERROR="ERROR: mainfile.tex contains another \\includeonly... exiting"

egrep '^\\includeonly{module*' mainfile.tex && echo $ERROR && exit

# loop over modules
for((i=1;i<=10;i++)); do
    # modules 1-10
    pdflatex "\def\myfile{module${i}} \input{mainfile.tex}"
	#pdflatex "\includeonly{module${i}} \input{mainfile.tex}
    cp mainfile.pdf module${i}.pdf
done
exit
