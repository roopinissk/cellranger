# get_fastq.py
# enter the sra numbers you want to download here
# then run this script to download and convert to fastq.gz files
import os, subprocess
# this changes according to the dataset you want to download
SRA_NUMBERS = [
    "SRR17873077", "SRR17873078", "SRR17873079", "SRR17873080",
    "SRR17873081", "SRR17873082", "SRR17873083", "SRR17873084",
    "SRR17873085", "SRR17873086", "SRR17873087", "SRR17873088",
    "SRR17873089", "SRR17873090", "SRR17873091", "SRR17873092",
    "SRR17873093", "SRR17873094", "SRR17873095", "SRR17873096",
    "SRR17873097", "SRR17873098", "SRR17873099", "SRR17873100",
    "SRR17873101", "SRR17873102", "SRR17873103", "SRR17873104",
    "SRR17873105", "SRR17873106", "SRR17873107", "SRR17873108",
    "SRR17873109", "SRR17873110", "SRR17873111", "SRR17873112",
    "SRR17873113", "SRR17873114", "SRR17873115", "SRR17873116",
    "SRR17873117", "SRR17873118", "SRR17873119", "SRR17873120",
    "SRR17873121", "SRR17873122", "SRR17873123", "SRR17873124",
    "SRR17873125", "SRR17873126"
]


# Normalize the IDs (strip spaces/newlines)
SRA_NUMBERS = [s.strip() for s in SRA_NUMBERS]

# Download .sra files
for sra_id in SRA_NUMBERS:
    print("Currently downloading:", sra_id)
    prefetch_cmd = f"prefetch {sra_id} -O ."
    print("The command used was:", prefetch_cmd)
    subprocess.call(prefetch_cmd, shell=True)

# Convert each .sra into FASTQs (_1 and _2) and compress
for sra_id in SRA_NUMBERS:
    print("Generating FASTQ for:", sra_id)
    fastq_cmd = (
        f"fasterq-dump --split-files --include-technical -e 8 -O . " # include technical reads will give you all 3 files
        f"./{sra_id}/{sra_id}.sra"
    )
    print("The command used was:", fastq_cmd)
    subprocess.call(fastq_cmd, shell=True)

    # compress the outputs
    subprocess.call(f"pigz -p 8 {sra_id}_1.fastq", shell=True)
    subprocess.call(f"pigz -p 8 {sra_id}_2.fastq", shell=True)
    subprocess.call(f"pigz -p 8 {sra_id}_3.fastq", shell=True)