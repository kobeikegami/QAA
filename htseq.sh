#!/usr/bin/bash
#SBATCH --partition=bgmp       ### Partition (like a queue in PBS)
#SBATCH --job-name=6_2D_re     ### Job Name/optional
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node, optional
#SBATCH --account=bgmp          ### Account used for job submission/
#SBATCH --cpus-per-task=8

#align_file="15_3C/Mus_musculus_alignmentAligned.out.sorted.sam"
align_file="6_2D/Mus_musculus_alignmentAligned.out.sorted.sam"
gtf="./Mus_musculus.GRCm39.107.gtf"
output="6_2D_rev_stranded.tsv"


/usr/bin/time -v htseq-count -r pos -s reverse $align_file $gtf > $output 