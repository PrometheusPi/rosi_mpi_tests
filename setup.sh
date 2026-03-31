# Name and Path of this Script ############################### (DO NOT change!)
export PIC_PROFILE=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)/$(basename ${BASH_SOURCE:-$0}) # for compatibility with both zsh and bash
# User Information ################################# (edit the following lines)
#   - automatically add your name and contact to output file meta data
#   - send me a mail on batch system jobs: NONE, BEGIN, END, FAIL, REQUEUE, ALL,
#     TIME_LIMIT, TIME_LIMIT_90, TIME_LIMIT_80 and/or TIME_LIMIT_50
export MY_MAILNOTIFY="NONE"
export MY_MAIL="someone@example.com"
export MY_NAME="$(whoami) <$MY_MAIL>"


# Text Editor for Tools ###################################### (edit this line)
#   - examples: "nano", "vim", "emacs -nw", "vi" or without terminal: "gedit"
export EDITOR="emacs -nw"

# General modules #############################################################
#
module purge
module load volta
module load emacs

# from Varun
ml use /data/rosi/shared/eb/easybuild/volta/modules/all/Core/*
ml NVHPC/22.7-CUDA-11.7.0
ml OpenMPI/4.1.4

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export OMPI_MCA_pml=ucx
export OMPI_MCA_btl=self,smcuda,vader

#module load GCC/12.3.0
#module load GCCcore/12.3.0
#module load cuda/12.8
#module load libfabric/1.18.0-GCCcore-12.3.0
#module load UCX/1.14.1-GCCcore-12.3.0
#module load OpenMPI/4.1.5-GCC-12.3.0
module load python/3.14.2
module load cmake/4.0.3
module load zlib/1.2.13-GCCcore-12.3.0

# Environment #################################################################
#
export CC="$(which cc)"
export CXX="$(which CC)"
export CUDACXX=$(which nvcc)

export MPI_CXX=$(which mpic++)
export MPI_CC=$(which mpicc)


# "tbg" default options #######################################################
#   - SLURM (sbatch)
#   - "gpu-v100" queue
export TBG_SUBMIT="sbatch"
#export TBG_TPLFILE="etc/picongpu/hemera-hzdr/fwkt_v100.tpl"
export TBG_partition="gpu-v100"


# allocate an interactive shell for one hour
#   getNode 2  # allocates two interactive nodes (default: 1)
function getNode() {
    if [ -z "$1" ] ; then
        numNodes=1
    else
        numNodes=$1
    fi
    srun  --time=1:00:00 --nodes=$numNodes --ntasks-per-node=4 --cpus-per-task=6 --gres=gpu:4 --mem=378000 -p $TBG_partition  --pty bash
}


