using CSV
using DataFrames

OUTPUT_DIR = joinpath(@__DIR__, "output")
MAX_TIME = 300.0

# Read output
output_ooqp = readdir(OUTPUT_DIR)
res_ooqp_ = [f[1:end-9] for f in output_ooqp]
sort!(res_ooqp_)

instance = copy(res_ooqp_)
time_OOQP = MAX_TIME .* ones(length(instance))
success_OOQP = zeros(Int, length(instance))

for (i, f) in enumerate(res_ooqp_)
        
    # read output file
    s = read(OUTPUT_DIR*"/$(f).mps.ooqp", String)

    # Check output
    if !occursin("*** SUCCESSFUL TERMINATION ***", s)
        # solver experienced issues
        time_OOQP[i] = MAX_TIME
        success_OOQP[i] = 0
    else
        # Parse ouput to get solving time
        s_ = split(s, "QP solved in ")[2]
        t = parse(Float64, split(s_, " seconds.\n")[1])
        if t <= MAX_TIME
            time_OOQP[i] = t
            success_OOQP[i] = 1
        else
            time_OOQP[i] = MAX_TIME
            success_OOQP[i] = 0
        end

    end
end


# Create dataframe of results
df = DataFrame()
df.instance = instance
df.time_OOQP = time_OOQP
df.success_OOQP = success_OOQP

CSV.write("./res_ooqp.csv", df)