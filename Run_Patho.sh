#!/bin/bash

#Define pathoscope location
pathoscope="/Users/evan/apps/pathoscope2/pathoscope/./pathoscope.py" #?

LIB_DIR= # "~evan/apps/genome_library"
TARGET= # 
"virus_nt_ti,fungi_nt_ti,bacteria_nt_ti_0,bacteria_nt_ti_1,bacteria_nt_ti_2"
FILTER= # "human_nt_ti_0,human_nt_ti_1"
BT_HOME= # "/Users/evan/apps/bowtie2-2.1.0/"
FQ_DIR= # "?"

echo "FASTQ directory: "$FQ_DIR

## quality control and read trimming
#pathoqc -1 1A.fastq -m 30 -q 3 -e 50 -d 14 -p 8
#for FILE in $FQ_DIR/*.fastq
#do
#       pathoqc -1 $FILE -o $FQ_DIR -m 30 -q 3 -e 50 -d 14 -p 8
#done


##Alignment 
echo "Beginning PathoMap"

#for FILE in $FQ_DIR/*_tr.fq #with pathoQC ????? the ending extension? 
do 
	echo "Aligning "$FILE
	pathoscope MAP -U $FILE -outDir $FQ_DIR -outAlign 
${FILE##*/}.sam -expTag ${FILE##*/} -indexDir $LIB_DIR 
-targetIndexPrefixes $TARGET -filterIndexPrefixes $FILTER
	rm $FILE-* #clean up extra files
done

## Pathogen Detection
echo "Beginning PathoID"
for FILE in $FQ_DIR/*.fastq.sam
do 
	echo "Pathogen detection on: "$FILE
	pathoscope ID -alignFile $FILE -outDir $FQ_DIR -expTag 
${FILE##*/} 
done
