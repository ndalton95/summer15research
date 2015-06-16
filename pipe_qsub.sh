#!/bin/bash

cd # Wherever the data is stored

for FILE in ./*_1.clipped.fastq.gz # however the data is documented
do 

	FILE_ONE=$(basename $FILE)
	FILE_TWO=${FILE_ONE//_1*}_2.clipped.fastq.gz # make sure extension is correct 
	OUT_FILE=${FILE_ONE//_1*}.sam
	echo "pathoscope/pathoscope.py MAP -1 $FILE_ONE -2 -targetIndexPrefix virus_nt_ti,fungi_nt_ti -filterIndexPrefixes human_nt_ti_0,human_nt_ti_1 -indexDir ~evan/apps/genome_library -outAlign $OUT_FILE -expTag ${FILE_ONE//_1*} >> Practice.txt
	echo "pathoscope/pathoscope.py ID -alignFile $OUT_FILE -expTag ${FILE_ONE//_1*} --noUpdatedAlignFile" >> Practice.txt
	echo "rm *.sam" >> Practice.txt
