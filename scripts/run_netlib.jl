dirname = @__DIR__
dirname[end] == '/' || (dirname = dirname * "/")
dir_netlib = dirname * "../dat/netlib/"

include("./benchmark.jl")

# First compilation round
@info "Compilation rounds... This may take a few minutes"
results = benchmark(
    dir_netlib,
    ["AFIRO.SIF"],
    [SOLVERS_OS; SOLVERS_COMM],
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
    [SOLVERS_OS; SOLVERS_COMM],
    verbose=true
);

# extract results
@info "Parsing results"
df = extract_results(results)

# Export individual results
@info "Exporting to csv file"
CSV.write(dirname*"res_netlib.csv", df)