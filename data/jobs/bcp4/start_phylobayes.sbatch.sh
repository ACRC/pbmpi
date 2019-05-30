#!/bin/bash
# -------------------
# Slurm starter script for start_phylobayes.py
# -------------------
#SBATCH --job-name=start_phylobayes
#SBATCH --output=start_phylobayes_%j.out
#SBATCH --partition=veryshort
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=5:59:00
# Set ntasks to:
# number_of_processes [times] number_of_chains
# if number_of_processes == 1 -> pb
# if number_of_processes > 1 -> pb_mpi
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
##SBATCH --mail-type=END,FAIL
##SBATCH --mail-user=email@address.address

# We assume that a single (alignment) filename was
# given to this script
# e.g. sbatch start_phylobayes.sbatch.sh /path/to/input_file

module purge

### GNU COMPILER - Prebuilt
#module load OpenMPI/OpenMPI/2.0.2-GCC-6.3.0-2.27
#module load apps/phylobayes/mpi-1.8.gnu
#export I_MPI_PMI_LIBRARY=/mnt/storage/easybuild/software/OpenMPI/2.0.2-GCC-6.3.0-2.27/lib/libmpi.so


### INTEL COMPILER - Prebuilt
#module load apps/phylobayes/1.8.intel
#export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

### INTEL COMPILER - New Build
module load languages/intel/2017.01
PATH=/mnt/storage/home/hw16471/summer19/phylobayes-mpi/data/intel_build/:$PATH
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so


### GNU COMPILER - New Build
#module load languages/intel/2017.01
#PATH=/mnt/storage/home/hw16471/summer19/phylobayes-mpi/data/gnu_build/:$PATH
#export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

which pb_mpi

python start_phylobayes.py --input=$1 \
--pb-args="-cat -gtr -x 1 2000 "      \
--chains=1                       \
--max-diff-bpcomp=0.3            \
--effective-size-tracecomp=50.0  \
--relative-diff-tracecomp=0.3    \
--max-sample-size=100000         \
--min-sample-size=6667           \
--sleep-range-min=600           \
--sleep-range-max=600           \
#--processes=1  # Processes is infered from Slurm environment variables

