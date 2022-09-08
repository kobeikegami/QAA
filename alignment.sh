#!/usr/bin/bash
#SBATCH --partition=bgmp       ### Partition (like a queue in PBS)
#SBATCH --job-name=alignment      ### Job Name/optional
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node, optional
#SBATCH --account=bgmp          ### Account used for job submission/
#SBATCH --cpus-per-task=8

R1="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/trimmed_reads/6_2D_mbnl_S5_L008_R1_001_trimmed_paired.fq.gz"
R2="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/trimmed_reads/6_2D_mbnl_S5_L008_R2_001_trimmed_paired.fq.gz"
gen_dir="/projects/bgmp/kikegami/bioinfo/Bi623/qaa/dre"

conda activate qaa

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn  $R1 $R2 \
    --genomeDir $gen_dir \
    --outFileNamePrefix Mus_musculus_alignment

