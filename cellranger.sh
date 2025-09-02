# Safer bash: turn on -u only AFTER module load (cellranger sourceme uses unset vars)
set -e -o pipefail
mkdir -p logs

# FASTQs live here:
FASTQ_DIR= # path to your fastq files
# Reference:
TRANSCRIPTOME= # path to your genome reference
# Where to put cellranger outputs:
RESULTS_DIR= # path to your results directory

module load cellranger/7.0.1
set -u

mkdir -p "$RESULTS_DIR"

declare -A SAMPLE_MAP

# Cellranger runs separately for each sample; map SRA run accessions to desired output IDs
# I renamed them according to convienience. It gives me the disease status and last 2 digits of sra number.

# Healthy Donors
SAMPLE_MAP["SRR17873077"]="wu_HD77"
SAMPLE_MAP["SRR17873078"]="wu_HD78"
SAMPLE_MAP["SRR17873079"]="wu_HD79"
SAMPLE_MAP["SRR17873080"]="wu_HD80"
SAMPLE_MAP["SRR17873081"]="wu_HD81"
SAMPLE_MAP["SRR17873082"]="wu_HD82"
SAMPLE_MAP["SRR17873083"]="wu_HD83"
SAMPLE_MAP["SRR17873117"]="wu_HD117"
SAMPLE_MAP["SRR17873118"]="wu_HD118"
SAMPLE_MAP["SRR17873119"]="wu_HD119"
SAMPLE_MAP["SRR17873120"]="wu_HD120"
SAMPLE_MAP["SRR17873121"]="wu_HD121"
SAMPLE_MAP["SRR17873122"]="wu_HD122"
SAMPLE_MAP["SRR17873123"]="wu_HD123"
SAMPLE_MAP["SRR17873124"]="wu_HD124"
SAMPLE_MAP["SRR17873125"]="wu_HD125"
SAMPLE_MAP["SRR17873126"]="wu_HD126"

# UPN10
SAMPLE_MAP["SRR17873084"]="wu_UPN10_84"
SAMPLE_MAP["SRR17873085"]="wu_UPN10_85"
SAMPLE_MAP["SRR17873086"]="wu_UPN10_86"
SAMPLE_MAP["SRR17873087"]="wu_UPN10_87"
SAMPLE_MAP["SRR17873088"]="wu_UPN10_88"
SAMPLE_MAP["SRR17873089"]="wu_UPN10_89"
SAMPLE_MAP["SRR17873090"]="wu_UPN10_90"
SAMPLE_MAP["SRR17873091"]="wu_UPN10_91"
SAMPLE_MAP["SRR17873092"]="wu_UPN10_92"

# UPN13
SAMPLE_MAP["SRR17873093"]="wu_UPN13_93"
SAMPLE_MAP["SRR17873094"]="wu_UPN13_94"
SAMPLE_MAP["SRR17873095"]="wu_UPN13_95"
SAMPLE_MAP["SRR17873096"]="wu_UPN13_96"
SAMPLE_MAP["SRR17873097"]="wu_UPN13_97"
SAMPLE_MAP["SRR17873098"]="wu_UPN13_98"
SAMPLE_MAP["SRR17873099"]="wu_UPN13_99"
SAMPLE_MAP["SRR17873100"]="wu_UPN13_100"
SAMPLE_MAP["SRR17873101"]="wu_UPN13_101"
SAMPLE_MAP["SRR17873102"]="wu_UPN13_102"
SAMPLE_MAP["SRR17873103"]="wu_UPN13_103"
SAMPLE_MAP["SRR17873104"]="wu_UPN13_104"
SAMPLE_MAP["SRR17873105"]="wu_UPN13_105"
SAMPLE_MAP["SRR17873106"]="wu_UPN13_106"
SAMPLE_MAP["SRR17873107"]="wu_UPN13_107"
SAMPLE_MAP["SRR17873108"]="wu_UPN13_108"

# UPN14
SAMPLE_MAP["SRR17873109"]="wu_UPN14_109"
SAMPLE_MAP["SRR17873110"]="wu_UPN14_110"

# UPN15
SAMPLE_MAP["SRR17873111"]="wu_UPN15_111"
SAMPLE_MAP["SRR17873112"]="wu_UPN15_112"

# UPN16
SAMPLE_MAP["SRR17873113"]="wu_UPN16_113"
SAMPLE_MAP["SRR17873114"]="wu_UPN16_114"

# UPN17
SAMPLE_MAP["SRR17873115"]="wu_UPN17_115"
SAMPLE_MAP["SRR17873116"]="wu_UPN17_116"

# Run cellranger, one output folder per ID under RESULTS_DIR ---
cd "$RESULTS_DIR"

for SRR in $(printf "%s\n" "${!SAMPLE_MAP[@]}" | sort); do
  ID="${SAMPLE_MAP[$SRR]}"
  echo "Running cellranger for $SRR -> $ID"
  cellranger count \
    --id="$ID" \
    --transcriptome="$TRANSCRIPTOME" \
    --fastqs="$FASTQ_DIR" \
    --sample="$SRR" \
    --localcores=16 \      # you can change this according to your system
    --localmem=64          # you can change this according to your system
done