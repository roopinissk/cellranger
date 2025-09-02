This is an example workflow that uses the public dataset on GEO: GSE196052

It uses prefetch and fasterq-dump from the SRA toolkit, and pigz for compression.
The fasterq-dump command is set to use 8 threads and includes technical reads.
The result is that you will get 3 types of fastq files with suffix _1.fastq.gz, _2.fastq.gz, and _3.fastq.gz.
_1 is the index read about 8bp long,
_2 is barcode+UMI about 26 bp long, and 
_3 is the cDNA read about 100 bp long.

Before running cell ranger be sure to rename the files; it is important to have illumina seq names to have _R1, _R2, and _R3 suffixes instead of _1, _2, and _3. And only use _2 and _3 for cell ranger. The code fro running cell ranger in present under cellranger.sh