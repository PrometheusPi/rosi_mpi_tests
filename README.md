RoSI MPI tests
--------------

This is a simple MPI test build for testing the RoSI cluster.

To run the tests, please execute
```bash

source setup.sh

mpic++ hello.cpp -o hello
mpic++ pingpong.cpp -o pingpong

# single gpu-v100 node
sbatch 4.cfg

# 2 gpu-v100 nodes
sbatch 8.cfg
```
