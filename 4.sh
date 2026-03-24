#!/bin/bash

#SBATCH --partition=gpu-v100 
#SBATCH --time=1:00:00

# Sets batch job's name
#SBATCH --job-name=4_gpu_mpi_test
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --ntasks-per-node=4
#SBATCH --mincpus=4
#SBATCH --cpus-per-task=6
#SBATCH --mem=378000
#SBATCH --gres=gpu:4
#SBATCH --mail-type=NONE

#SBATCH -o 4_stdout
#SBATCH -e 4_stderr


export OMPI_MCA_pml=ob1
export OMPI_MCA_btl=self,smcuda,vader

echo "==== hostname ===="
echo "==== hostname ====" >&2
srun --mpi=pmix hostname

echo "==== hello world ===="
echo "==== hello world ====" >&2
srun --mpi=pmix ./hello


echo "==== pingpong ===="
echo "==== pingping ====" >&2
#srun --mpi=pmix ./pingpong
mpiexec -n 4 ./pingpong

echo "==== cuda memtest ===="
echo "==== cuda memtest ====" >&2

