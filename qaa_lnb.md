QAA Lab Notebook

31 AUG 2022

Navigate to /projects/bgmp/shared/Bi622/QAA_data_assignments.txt in Talapas to find livrary assignment
I was assigned the following:

Kobe    6_2D_mbnl_S5_L008       15_3C_mbnl_S11_L008

6_2D_mbnl_S5_L008_R1_001.fastq.gz
6_2D_mbnl_S5_L008_R2_001.fastq.gz

15_3C_mbnl_S11_L008_R1_001.fastq.gz 
15_3C_mbnl_S11_L008_R2_001.fastq.gz

Use the following path to access the demultiplexed data for assigned library:

/projects/bgmp/shared/2017_sequencing/demultiplexed/

module spider fastqc too find version to run

run module load (ml) fastqc/0.11.5

run fastqc on one file at a time with the following cli input parameters

$ fastqc /projects/bgmp/shared/2017_sequencing/demultiplexed/6_2D_mbnl_S5_L008_R1_001.fastq.gz -o . -f fastq

This is done for both R1 and R2 of each library, resulting in 4 runs in total

06 SEP 2022

Create a new conda environment using the following CLI:

conda create --name qaa
conda activate

conda install cutadapt
conda install trimmomatic

check versions with:
cutadapt --version (4.1)
trimmomatic -- verison (0.39)

Data exploration!
Open your assigned demultiplexed filed and disocver what the adapter sequences are
    R1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
    R2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

Cutadapt CLI:

Made a slurm script to simplify the inputs for cutadapt called trim.sh. It specifies inputs, outputs, and adapters as variables

    cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o 6_2D_mbnl_S5_L008_R1_001_trimmed.fastq.gz -p 6_2D_mbnl_S5_L008_R2_001_trimmed.fastq.gz
    /projects/bgmp/shared/2017_sequencing/demultiplexed/6_2D_mbnl_S5_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/6_2D_mbnl_S5_L008_R2_001.fastq.gz

Trimmomatic:
    
    /usr/bin/time -v trimmomatic  \
PE \
6_2D_mbnl_S5_L008_R1_001_trimmed.fastq.gz \
6_2D_mbnl_S5_L008_R2_001_trimmed.fastq.gz \
6_2D_mbnl_S5_L008_R1_001_trimmed_paired.fq.gz \
6_2D_mbnl_S5_L008_R1_001_trimmed_unpaired.fq.gz \
6_2D_mbnl_S5_L008_R2_001_trimmed_paired.fq.gz \
6_2D_mbnl_S5_L008_R2_001_trimmed_unpaired.fq.gz \
LEADING:3 TRAILING:3 \
SLIDINGWINDOW:5:15 MINLEN:35

Filter for Unique values and sort them based on size using the following CLi from ICA 4:
zcat 15_3C_mbnl_S11_L008_R2_001_trimmed_unpaired.fq.gz | sed -n '2~4p' | awk '{print length($0)}'| sort -n | uniq -c > 15_3C_mbnl_S11_L008_R2_001_trimmed_unpaired.txt
Download The 4 outputs for each library to your local computer and plot the paired files them in R, R1 and R2 from each library will be plotted on the same graph so display their differences, if any, in reads length distribution

Part 3

In QAA environment, Conda install:
star (2.7.10a)
numpy 
pysam
matplotlib
htseq

Downloading Mouse Ensembl 107 Fasta File:

Go to ensembl, then downloads/ftpdownloads/MouseDNAFasta and downloads/ftpdownloads/GeneSets/GTF/Mus_musculus.GRCm39.107.gtf.gz, control click and copy the link addresses separately, download to working directory with:
wget http://ftp.ensembl.org/pub/release-107/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz

Star Database Directory:
mkdir Mus_musculus.GRCm39.dna.primary_assembly.STAR2.7.10a

copy gengen.sh from PS8 directory and modify it to create a database for this project

run gengen.sh

Copy alignment.sh from PS8 folder and adjust file inputs for this assignment:

    R1="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/trimmed_reads/6_2D_mbnl_S5_L008_R1_001_trimmed_paired.fq.gz"
    R2="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/trimmed_reads/6_2D_mbnl_S5_L008_R2_001_trimmed_paired.fq.gz"
    gen_dir="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/dre"

Run alignment.sh

Copy PS8.py, rename and adjust input files for this assignment.
Interctive node:
    srun --account=bgmp --partition=bgmp --nodes=1 --ntasks-per-node=1 --time=2:00:00 --cpus-per-task=8 --pty bash

conda install samtools -c bioconda
sort sam files and save them as a new file with a sorted format:

    $samtools sort Mus_musculus_alignmentAligned.out.sam -o Mus_musculus_alignmentAligned.out.sorted.sam

Run each sorted same file through htseq-count with the following slurm script:
 
    align_file="15_3C/Mus_musculus_alignmentAligned.out.sorted.sam"
    #align_file="6_2D/Mus_musculus_alignmentAligned.out.sorted.sam"
    gtf="./Mus_musculus.GRCm39.107.gtf"


    /usr/bin/time -v htseq-count -r pos -s yes $align_file $gtf > "6_2D_yes_stranded" 

    NOTE: -r pos is for sorted sam, -s yes (stranded) and -s reverse (run each sam with both -s conditions for a total of 4 runs)















