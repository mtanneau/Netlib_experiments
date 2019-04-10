dirname = @__DIR__
include(dirname * "/benchmark.jl")

# First compilation round
@info "Compilation rounds... This may take a few minutes"
results = benchmark(
    ["AFIRO.SIF"],
    [SOLVERS_OS; SOLVERS_COMM],
    verbose=false
);

# Compilation round for Tulip
benchmark(
    readdir(dirname*"../dat/netlib"),
    [sTLP()],
    verbose=false
);

# Real deal
@info "Launching Netlib benchmark"
flush(stdout)
results = benchmark(
    readdir(dirname*"../dat/netlib"),
    [SOLVERS_OS; SOLVERS_COMM],
    verbose=true
);

# extract results
@info "Parsing results"
df = extract_results(results)

# write to CSV file
@info "Exporting to csv file"
CSV.write(dirname*"../res_netlib.csv", df)