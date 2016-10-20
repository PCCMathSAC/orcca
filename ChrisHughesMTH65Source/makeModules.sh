#!/bin/bash
# 
# A file to make module1.pdf, module2.pdf, ..., module10.pdf
#

# page numbers- have to specify this manually
pages=(1 17 32 45 50 65 85 96 104 117 130)

# initialize module counter
moduleCounter=1

# loop through the page numbers and create modules
for((i=0;i<10;i++)); do
 # modules 1-9 finish at the next module's page number-1
 # module 10 is different, as it finishes at the end of the document
 if [ $i -eq 9 ]
 then
    echo module$moduleCounter
    dvips -pp${pages[$i]}-$[pages[$[i+1]]] mainfile.dvi -o module$moduleCounter.ps
    ps2pdf module$moduleCounter.ps module$moduleCounter.pdf
    exit
 fi

 # modules 1-9
 echo module$moduleCounter
 dvips -pp${pages[$i]}-$[pages[$[i+1]]-1] mainfile.dvi -o module$moduleCounter.ps
 ps2pdf module$moduleCounter.ps module$moduleCounter.pdf
 moduleCounter=$[moduleCounter+1]
done
exit
