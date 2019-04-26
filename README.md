# Netlib LP experiments

This supplement is for reproducing the computational tests in Section 6.1 of "...".

## Installation instructions

### Install Julia

To run the experiments, you need Julia v1.0 or above.
Download and installation instructions can be found [here](https://julialang.org/downloads/).


### Install solvers:
1. Commercial solvers require a license and must be installed separately.
    * [CPLEX](https://www.ibm.com/products/ilog-cplex-optimization-studio)
    * [Gurobi](https://www.gurobi.com)
    * [Mosek](https://www.mosek.com)
2. Download and compile OOQP
    * Download the OOQP code, available [here](https://github.com/emgertz/OOQP).
    Checkout version 0.99.27:
    ```bash
    git checkout OOQP-0.99.27
    ```
    * Obtain a license and download the MA27 library from [HSL](http://www.hsl.rl.ac.uk/)
    * Compile OOQP (see installation instructions)
    * The executable file we used for experiments is `qpgen-sparse-gondzio.exe`.
3. Other open-source solvers will be downloaded automatically when installing their respective Julia APIs.


### Clone this repository
```bash
git clone https://github.com/mtanneau/Netlib_experiments.git
```


### Install Julia packages

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

In particular, this step will automatically download and locally install open-source solvers Clp, ECOS, GLPK and IpOpt.
Additional steps may be required for building the Julia interface of commercial solvers. See installation instructions for each solver's API.

### Download the Netlib LP testset.

You may use the script `download_netlib.sh`, located in the `dat/` folder.
```bash
cd dat/
chmod +x download_netlib.sh
./download_netlib.sh
```
This will download all 114 instances in `.SIF` format.

The MPS reader we use accepts `.SIF` files, but OOQP's does not (it requires `.mps` files).
To obtain files in the `.mps` format, simply remove emtpy lines and those that begin with a `*`.


## Run the experiments

1. OOQP
    * Copy-paste netlib instances (in `.mps` format!) into `ooqp/netlib` folder.
    * Run the experiments with OOQP
    ```bash
    cd ooqp/
    mkdir output
    chmod +x run_ooqp.sh
    ```
    Note that the command-line executable does not allow to specify time limits nor number of threads. By default, OOQP (or, more exactly, calls to MA27) may use all available cores.
    
    Output files for each instance will be located in `ooqp/output`
    * Parse the results
    ```
    julia --project=. ooqp/parse_ooqp_output.jl
    ```
    This will parse each output file in `ooqp/output`, and save the results in `ooqp/res_ooqp.csv`.


2. Other solvers

    Just run the following command (from the root of the directory):
    ```bash
    julia --project=. scripts/run_netlib.jl
    ```
    This will run a compilation round, then solve each Netlib instance with each solver.
    Computational results for each instance will be saved in `res_netlib.csv` file.


## Post-processing

1. Merge results

    Copy-paste the two columns `time_OOQP` and `success_OOQP` from `ooqp/res_ooqp.csv` into `scripts/res_netlib.csv`.

2. Create tables

    To compute the performance statistics reported in Section 6.1, run the command
    ```bash
    julia --project=. process_results.jl res_netlib.csv
    ```

    This will output Latex code for the corresponding tables.
