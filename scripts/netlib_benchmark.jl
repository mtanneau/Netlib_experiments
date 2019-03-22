using Printf
using Random

using LinearAlgebra
BLAS.set_num_threads(1)

import MathProgBase
const MPB = MathProgBase


import Clp:ClpSolver
import ECOS:ECOSSolver
import GLPK
import GLPKMathProgInterface:GLPKSolverLP
import Ipopt:IpoptSolver
import Mosek:MosekSolver
import Tulip

function benchmark_instance(model::MPB.AbstractLinearQuadraticModel, res; verbose=false)
    
    res[:success] = false
    res[:fail] = false
    res[:error] = false
    
    try
        t = @elapsed MPB.optimize!(model)
        s = MPB.status(model)
        
        res[:time] = t
        res[:status] = "$s"
        # res[:iter] = MPB.getbarrieriter(model)

        if s == :Optimal
            verbose && @printf "%8.2f s" t
            res[:success] = true
        else
            verbose && @printf "%8.2f t" t
            res[:fail] = true
        end
            
    catch err
        verbose && @printf "%8.2f f" 0Inf
        # verbose && print(typeof(err))
        res[:error] = true
        res[:error_type] = "$(typeof(err))"
        res[:time] = Inf
    end
    
    flush(stdout)
    
    return
end

function benchmark(files, solvers, names; verbose=false)
    
    @assert length(solvers) == length(names)
    
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
            
            results[name][f] = Dict()
            
            # Instanciate model
            model = MPB.LinearQuadraticModel(s)
            MPB.loadproblem!(model, A, collb, colub, c, b, b, :Min)
            
            benchmark_instance(model, results[name][f], verbose=verbose)
        end
            
        verbose && @printf "\n"
        flush(stdout)

    end
    
    return results
end

function main()

    # Solvers
    s_clp = ClpSolver(
        LogLevel=0,
        PresolveType=1,
        SolveType=4,
        MaximumSeconds=300
    );

    s_ecos = ECOSSolver(
        verbose=0
    )

    s_glpk = GLPKSolverLP(
    #   presolve=true,  # no pre-solve for interior-point (apparently)
        method=:InteriorPoint,
        msg_lev=0
    );

    s_ipo = IpoptSolver(
        print_level=0,
        max_cpu_time=300.0,
    );

    s_msk = MosekSolver(
        MSK_IPAR_INTPNT_BASIS=0,
        MSK_IPAR_NUM_THREADS=1,
        MSK_IPAR_PRESOLVE_USE=0,
        MSK_IPAR_LOG=0,
        MSK_DPAR_OPTIMIZER_MAX_TIME=300
    );

    s_tlp = Tulip.TulipSolver(
        verbose=0,
        time_limit=300,
        barrier_iter_max=200,
        algo=1
    );

    solvers = [
        # s_clp,
        # s_ecos,
        # s_glpk,
        # s_ipo,
        # s_msk,
        s_tlp
    ]
    names = [
        # :CLP,
        # :ECOS,
        # :GLPK,
        # :IPO,
        # :MSK,
        :TLP
    ]

    # First compilation round
    results = benchmark(
        ["AFIRO.SIF"],
        solvers,
        names,
        verbose=false
    );

    # Real deal
    results = benchmark(
        readdir("../dat/netlib"),
        solvers,
        names,
        verbose=true
    );

    for metric in [:time, :success]
        @printf "%8s" "$metric"
        for solver in names
            @printf "%8.2f" total(results, metric, solver)
        end
        @printf "\n"
    end

    return
end

total(results, metric, solver) = sum([
    res[metric]
    for (k, res) in results[solver]
        if haskey(res, metric) && res[metric] < Inf
])

main()