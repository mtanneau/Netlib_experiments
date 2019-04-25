using CSV
using DataFrames
using Printf
using Statistics

const DIR = @__DIR__
const ROOT_DIR = joinpath(@__DIR__, "..")

"""
    gmean1(u)

Compute the geometric mean with a shift of 1.
"""
gmean1(u) = exp(mean(log.(u .+ oneunit(eltype(u))))) - oneunit(eltype(u))


# results file name
res_file_name = ARGS[1]

# Import results
df = CSV.read(res_file_name)
# Import instance sizes
df_sizes = CSV.read(ROOT_DIR * "/dat/instances.csv")

# Compute aggregated statistics
# First, compute sets of instances
N = length(df.instance)
N_all = trues(N)
N_solved = trues(N)  # instances solved by all solvers
for s in [:CLP, :ECOS, :GLPK, :IPOPT, :OOQP, :TLP, :CPX, :GRB, :MSK]
    N_solved .*= df[Symbol("success_$(s)")]
end

println("$N instances")
println("$(sum(N_solved)) solved by all solvers")

N_small = (df_sizes.nrows + df_sizes.ncols) .< 1e3
N_medium = (1e3 .<= (df_sizes.nrows + df_sizes.ncols) .< 1e4)
N_large = 1e4 .<= (df_sizes.nrows + df_sizes.ncols)

println("$(sum( N_small))  small instances")
println("$(sum(N_medium)) medium instances")
println("$(sum( N_large))  large instances")

N_small .*= N_solved
N_medium .*= N_solved
N_large .*= N_solved

println("$(sum( N_small))  small  instances (solved)")
println("$(sum(N_medium)) medium  instances (solved)")
println("$(sum(N_large))   large  instances (solved)")

println("\n\n")

# Open-source solvers
println("\\toprule")
print("        \t &")
for s in [:CLP, :ECOS, :GLPK, :IPOPT, :OOQP, :TLP]
    @printf "& %6s \t " s
end
println("\\\\")
println("\\midrule")

print("Solved  \t &")
for s in [:CLP, :ECOS, :GLPK, :IPOPT, :OOQP, :TLP]
    @printf "& \$%6d\$\t " sum(df[Symbol("success_$s")][N_all])
end
println("\\\\")
println("\\midrule")

# Computing times
for (setname, pbset) in zip(
        ["N-$N", "N-$(sum(N_solved))", "N-small", "N-medium", "N-large"],
        [N_all, N_solved, N_small, N_medium, N_large]
    )
    @printf "%8s\t &" setname
    for s in [:CLP, :ECOS, :GLPK, :IPOPT, :OOQP, :TLP]
        @printf "& \$%6.3f\$\t " gmean1(df[Symbol("time_$s")][pbset])
    end
    println("\\\\")
end
println("\\bottomrule")

println("\n\n\n")

# Commercial solvers
println("\\toprule")
print("        \t &")
for s in [:CPX, :GRB, :MSK]
    @printf "& %6s\t " s
end
println("\\\\")
println("\\midrule")

print("Solved  \t &")
for s in [:CPX, :GRB, :MSK]
    @printf "& \$%6d\$\t " sum(df[Symbol("success_$s")][N_all])
end
println("\\\\")
println("\\midrule")

# Computing times
for (setname, pbset) in zip(
        ["N-$N", "N-$(sum(N_solved))", "N-small", "N-medium", "N-large"],
        [N_all, N_solved, N_small, N_medium, N_large]
    )
    @printf "%8s\t &" setname
    for s in [:CPX, :GRB, :MSK]
        @printf "& \$%6.3f\$\t " gmean1(df[Symbol("time_$s")][pbset])
    end
    println("\\\\")
end
println("\\bottomrule")