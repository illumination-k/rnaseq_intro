#!/bin/bash

docker run --rm -it -v $(pwd):/local_volume illumination27/sra-tools:latest \
	fasterq-dump SRR5826942 -e 6

docker run --rm -it -v $(pwd):/local_volume illumination27/fastp:latest \
	fastp -i SRR5826942.fastq -o SRR5826942_trim.fastq.gz -j SRR5826942.json -h SRR5826942.html -w 6

docker run --rm -it -v $(pwd):/local_volume illumination27/salmon-tximport:latest \
	salmon quant -i ./arabidopsis_ref/salmon_index \
	-l A -r SRR5826942_trim.fastq.gz \
	-p 6 -o SRR5826942_exp