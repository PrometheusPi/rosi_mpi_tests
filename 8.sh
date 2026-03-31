#!/bin/bash

#SBATCH --partition=gpu-v100 
#SBATCH --time=1:00:00

# Sets batch job's name
#SBATCH --job-name=8_gpu_mpi_test
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --ntasks-per-node=4
#SBATCH --mincpus=4
#SBATCH --cpus-per-task=6
#SBATCH --mem=378000
#SBATCH --gres=gpu:4
#SBATCH --mail-type=NONE

#SBATCH -o 8_stdout
#SBATCH -e 8_stderr


export OMPI_MCA_pml=ucx
export OMPI_MCA_btl=self,smcuda,vader

echo "==== hostname ===="
echo "==== hostname ====" >&2
srun --mpi=pmix hostname

echo "==== hello world ===="
echo "==== hello world ====" >&2
#srun --mpi=pmix ./hello
srun --mpi=pmix_v4 ./hello

echo "==== pingpong ===="
echo "==== pingpong ====" >&2
#srun --mpi=pmix ./pingpong
#mpirun -mca pml ucx -mca btl '^uct,ofi' -mca mtl '^ofi' -bind-to core --map-by core -n 8 ./pingpong
#mpirun --cpu-bind-=core -n 8 ./pingpong
srun --mpi=pmix_v4 ./pingpong

echo "==== end ===="
echo "==== end ====" >&2

