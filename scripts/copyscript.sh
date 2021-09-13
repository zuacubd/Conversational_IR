#!/bin/bash

#SBATCH --job-name=data_copy
#SBATCH --mail-type=END
#SBATCH --output=output/log/datacopy.log

scp -r /users/sig/mullah/ir/smolina/Mesures_IR/GOV2 .
