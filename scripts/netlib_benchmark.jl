using Printf
using Random

using DataFrames
using CSV

using Statistics
using LinearAlgebra
BLAS.set_num_threads(1)

import MathProgBase
const MPB = MathProgBase

import Tulip

DIRNAME = @__DIR__

global const TIME_LIMIT = 300

"""
    gmean1(u)

Compute the geometric mean with a shift of 1.
"""
gmean1(u) = exp(mean(log.(u .+ oneunit(eltype(u))))) - oneunit(eltype(u))

# import solvers
include("solvers.jl")

# open-source solvers
const SOLVERS_OS = [sCLP(), sECOS(), sGLPK(), sIPOPT(), sTLP()]
const NAMES_OS   = solver_name.(SOLVERS_OS)

# commercials solvers
const SOLVERS_COMM = [sCPX(), sGRB(), sMSK()]
const NAMES_COMM   = solver_name.(SOLVERS_COMM)

"""
    benchmark(files, solvers names; verbose)

Benchmark the given solvers over the set of instances.
"""
function benchmark(files, solvers;
    verbose=false
)
    
    names = solver_name.(solvers)
    
    time_tot = 0.0  # Total solve time

    n_err_read = 0
    n_err_solve = 0
    n_term = 0
    n_success = 0

    results = Dict()

    # Initial log
    verbose && @printf "%12s" ""
    for (s, name) in zip(solvers, names)
        results[name] = Dict{String, Dict}()
        verbose && @printf "%10s" name
    end
    verbose && @printf "\n"
    
    for f in files
        verbose && @printf "%12s" f
        
        # Read MPS file
        m, n, c, b, A, collb, colub, ranges = Tulip.readmps("../dat/netlib/" * f)
    
        for (s, name) in zip(solvers, names)
            
            res = Dict()
            
            # Instanciate model
            model = MPB.LinearQuadraticModel(s)
            MPB.loadproblem!(model, A, collb, colub, c, b, b, :Min)
            
            res[:success] = false
            res[:fail] = false
            res[:error] = false
            res[:status] = :Error
            res[:time] = NaN
            res[:error_type] = "None"
            
            try
                t = @elapsed MPB.optimize!(model)
                s = MPB.status(model)
                
                res[:time] = t
                res[:status] = "$s"
                # res[:iter] = MPB.getbarrieriter(model)

                if s == :Optimal && t <= TIME_LIMIT
                    # Instance is solved
                    verbose && @printf "%10.3f" t
                    res[:success] = true
                else
                    # Error or timeout
                    verbose && @printf "%10s" "t"
                    res[:time] = Float64(TIME_LIMIT)         # count failure as max time.
                    res[:fail] = true
                end
                    
            catch err
                verbose && @printf "%10s" "f"
                res[:error] = true
                res[:error_type] = "$(typeof(err))"
                res[:time] = Float64(TIME_LIMIT)
            end
            
            flush(stdout)

            results[name][f] = res
    
        end
            
        verbose && @printf "\n"
        flush(stdout)

    end
    
    return results
end


function main()

    # Open-source solvers
    # First compilation round
    @info "Compilation rounds... This may take a few minutes"
    benchmark(
        ["AFIRO.SIF"],
        [SOLVERS_OS; SOLVERS_COMM],
        verbose=false
    );
    # Compilation round for Tulip
    benchmark(
        readdir("../dat/netlib"),
        [sTLP()],
        verbose=false
    );

    # Real deal
    @info "Launching Netlib benchmark"
    flush(stdout)
    results = benchmark(
        readdir("../dat/netlib"),
        [SOLVERS_OS; SOLVERS_COMM],
        verbose=true
    );

    # println()
    # for metric in [:time, :success]
    #     @printf "%12s" "$metric"
    #     for solver in names
    #         @printf "%10.3f" total(results, metric, solver)
    #     end
    #     @printf "\n"
    # end

    # extract results
    df = extract_results(results)

    # write to CSV file
    CSV.write("./res_netlib.csv", df)

    return nothing
end

total(results, metric, solver) = sum([
    res[metric]
    for (k, res) in results[solver]
        if haskey(res, metric) && res[metric] < TIME_LIMIT
])

"""
    extract_results(res)

Parse results and output csv files.
"""
function extract_results(res)

    # Extract solvers
    solvers = collect(keys(res))

    # Extract problem names
    pbnames_raw = collect(keys(res[solvers[1]]))
    pbnames = lowercase.([f[1:end-4] for f in pbnames_raw])
    p = sortperm(pbnames)
    pbnames_raw = pbnames_raw[p]  # sort names
    pbnames = pbnames[p]
    
    # extract metrics
    metrics = collect(keys(res[solvers[1]][pbnames_raw[1]]))

    # Create data frame with all results
    df = DataFrame()
    
    df.instance = pbnames  # instance name
    for s in solvers
        for k in metrics
            df[Symbol("$(k)_$(s)")] = [res[s][f][k] for f in pbnames_raw]
        end
    end

    # convert boolean outputs to integers
    for s in solvers
        for k in metrics
            if eltype(df[Symbol("$(k)_$(s)")]) == Bool
                df[Symbol("$(k)_$(s)")] = Int.(df[Symbol("$(k)_$(s)")])
            end
        end
    end

    # Correct reported times
    for s in solvers
        t_ = df[Symbol("time_$s")]
        succ_ = df[Symbol("success_$s")]
        df[Symbol("time_$s")] .= min.(t_ , 300.0) .* succ_ .+ 300.0 .* (1.0 .- succ_)
    end

    return df
end

main()