dirname = @__DIR__
dirname[end] == '/' || (dirname = dirname * "/")
dir_netlib = dirname * "../dat/netlib/"

include("./benchmark.jl")

solvers = [SOLVERS_OS; SOLVERS_COMM]

# First compilation round
@info "Compilation rounds... This may take a few minutes"
results = benchmark(
    dir_netlib,
    ["AFIRO.SIF"],
    solvers,
    verbose=false
);

# Compilation round for Tulip
benchmark(
    dir_netlib,
    readdir(dir_netlib),
    [sTLP()],
    verbose=false
);

# Real deal
@info "Launching Netlib benchmark"
flush(stdout)
results = benchmark(
    dir_netlib,
    readdir(dir_netlib),
    solvers,
    verbose=true
);

# extract results
@info "Parsing results"
df = extract_results(results)

# Export individual results
@info "Exporting to csv file"
CSV.write(dirname*"res_netlib.csv", df)