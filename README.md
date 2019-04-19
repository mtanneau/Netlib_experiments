# Netlib LP experiments

This supplement is for reproducing the computational tests in Section 6.1 of "...".

## Installation instructions

### Cloning this repository
```bash
git clone https://github.com/mtanneau/Netlib_experiments.git
```

### Installing Julia

To run the experiments, you need Julia v1.0 or above.
Download and installation instructions can be found [here](https://julialang.org/downloads/).


### Installing solvers:
    1. Commercial solvers require a license and must be installed separately.
        * [CPLEX](https://www.ibm.com/products/ilog-cplex-optimization-studio)
        * [Gurobi](https://www.gurobi.com)
        * [Mosek](https://www.mosek.com)
    2. Open-source solvers will be downloaded automatically when installing their respective Julia APIs.

### Installing Julia packages

All package dependencies are specified in the `Project.toml` and `Manifest.toml` files located at the root of this directory.

To download and install those packages, run Julia from the root of this directory, and run the following commands
```julia
> using Pkg
> Pkg.activate(".")
> Pkg.instantiate()
```
or, from the terminal:
```bash
julia --project=. -e 'using Pkg; Pkg.instantiate();' 
```

Additional steps may be required for building the Julia interface of commercial solvers. See installation instructions for each solver's API.

### Downloading the Netlib LP testset.

You may use the script `download_netlib.sh`, located in the `dat/` folder.
```bash
chmod +x download_netlib.sh
./download_netlib.sh
```
This will download all 114 instances in `.SIF` format.
To obtain files in the `.mps` format, simply remove emtpy lines and those that begin with a `*`.


## Running the experiment

All experiments are run from a single command:
```bash
julia --project=. scripts/run_netlib.jl
```

This will run a compilation round, then solve each Netlib instance with each solver.
Computational results for each instance will be saved in `res_netlib.csv` file.

## Post-processing

To compute the performance statistics reported in Section 6.1, run the command
```bash
julia process_results.jl res_netlib.csv
```

This will output Latex code for the corresponding tables.