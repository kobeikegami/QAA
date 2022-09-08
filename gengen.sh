#!/usr/bin/bash
#SBATCH --partition=bgmp       ### Partition (like a queue in PBS)
#SBATCH --job-name=gengen      ### Job Name/optional
#SBATCH --nodes=1               ### Number of nodes needed for the job
#SBATCH --ntasks-per-node=1     ### Number of tasks to be launched per Node, optional
#SBATCH --account=bgmp          ### Account used for job submission/
#SBATCH --cpus-per-task=8
/usr/bin/time -v STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /projects/bgmp/kikegami/bioinfo/Bi623/qaa/dre \
--genomeFastaFiles dre/Mus_musculus.GRCm39.dna.primary_assembly.fa \
--sjdbGTFfile /projects/bgmp/kikegami/bioinfo/Bi623/qaa/Mus_musculus.GRCm39.107.gtf \