using CSV
using DataFrames
using Printf
using Statistics

# results file name
res_file_name = ARGS[1]

# Import results
df = CSV.read(res_file_name)

"""
    gmean1(u)

Compute the geometric mean with a shift of 1.
"""
gmean1(u) = exp(mean(log.(u .+ oneunit(eltype(u))))) - oneunit(eltype(u))

# Compute aggregated statistics
# First, compute sets of instances
netlib_all = trues(length(df.instance))
netlib_tlp = df.success_TLP .== 1
netlib_tlp_001 = (df.success_TLP .== 1) .& (df.time_TLP .> 0.01)
netlib_tlp_010 = (df.success_TLP .== 1) .& (df.time_TLP .> 0.10)

# Open-source solvers
println("\\toprule")
print("      \t &")
for s in [:CLP, :ECOS, :GLPK, :IPOPT, :TLP]
    @printf "& %6s \t " s
end
println("\\\\")
println("\\midrule")

print("Solved\t &")
for s in [:CLP, :ECOS, :GLPK, :IPOPT, :TLP]
    @printf "& \$%6d\$\t " sum(df[Symbol("success_$s")][netlib_all])
end
println("\\\\")
println("\\midrule")

# Computing times
for pbset in [netlib_all, netlib_tlp, netlib_tlp_001, netlib_tlp_010]
    @printf "%6s\t &" "N-$(sum(pbset))"
    for s in [:CLP, :ECOS, :GLPK, :IPOPT, :TLP]
        @printf "& \$%6.3f\$\t " gmean1(df[Symbol("time_$s")][pbset])
    end
    println("\\\\")
end
println("\\bottomrule")

println("\n\n\n")

# Commercial solvers
println("\\toprule")
print("      \t &")
for s in [:CPX, :GRB, :MSK]
    @printf "& %6s\t " s
end
println("\\\\")
println("\\midrule")

print("Solved\t &")
for s in [:CPX, :GRB, :MSK]
    @printf "& \$%6d\$\t " sum(df[Symbol("success_$s")][netlib_all])
end
println("\\\\")
println("\\midrule")

# Computing times
for pbset in [netlib_all, netlib_tlp, netlib_tlp_001, netlib_tlp_010]
    @printf "%6s\t &" "N-$(sum(pbset))"
    for s in [:CPX, :GRB, :MSK]
        @printf "& \$%6.3f\$\t " gmean1(df[Symbol("time_$s")][pbset])
    end
    println("\\\\")
end
println("\\bottomrule")