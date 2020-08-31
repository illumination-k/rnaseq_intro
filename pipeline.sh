#!/bin/bash

for f in $(cat SRR_Acc_List.txt); do
    docker run --rm -it -v $(pwd):/local_volume illumination27/sra-tools:latest \
        fasterq-dump ${f} -e 6

    docker run --rm -it -v $(pwd):/local_volume illumination27/fastp:latest \
        fastp -i ${f}.fastq -o ${f}_trim.fastq.gz -j ${f}.json -h ${f}.html -w 6

    docker run --rm -it -v $(pwd):/local_volume illumination27/salmon-tximport:latest \
        salmon quant -i ./arabidopsis_ref/salmon_index \
        -l A -r ${f}_trim.fastq.gz \
        -p 6 -o ${f}_exp
done