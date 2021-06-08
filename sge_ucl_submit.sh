#!/bin/bash
#Submit to the cluster, give it a unique name
#$ -S /bin/bash

#$ -cwd
#$ -V
#$ -l h_vmem=1.9G,h_rt=20:00:00,tmem=1.9G
#$ -pe smp 2

# join stdout and stderr output
#$ -j y
#$ -R y


snakemake \
-p \
--configfile config.yaml \
--use-singularity \
--jobscript sge_cluster_qsub.sh \
--singularity-args "--bind ${PWD}" \
--cluster-config cluster_config.json \
--cluster-sync "qsub -R y -l tmem={cluster.mem},h_vmem={cluster.mem},h_rt={cluster.time} -pe smp {cluster.threads} -o {params.cluster_log}" \
-j 40 \
--nolock \
--rerun-incomplete \
--latency-wait 100 \
--local-cores 1 \
--until complete_clustering
