using CSV
using DataFrames

const DIR = @__DIR__
const ROOT_DIR = joinpath(@__DIR__, "..")

res_file_all  = ARGS[1]
res_file_ooqp = ARGS[2]

# Read each results file
df_all = CSV.read(res_file_all)    # Non-OOQP solvers
df_ooqp = CSV.read(res_file_ooqp)  # OOQP results

# Merge results
# This will raise an error if `df_all` already containts `time_OOQP` and/or `success_OOQP`
df_merged = join(df_all, df_ooqp, on = :instance)

# Write results
CSV.write("res_merged.csv", df_merged)