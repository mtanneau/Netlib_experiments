import Clp:ClpSolver
import ECOS:ECOSSolver
import GLPK
import GLPKMathProgInterface:GLPKSolverLP
import Ipopt:IpoptSolver
import Tulip:TulipSolver

import CPLEX:CplexSolver
import Gurobi 
import Gurobi:GurobiSolver
import Mosek:MosekSolver

global const GRBENV = Gurobi.Env()  # define this to avoid extra prints

# Open-source solvers
sCLP() = ClpSolver(
    LogLevel=0,
    PresolveType=1,
    SolveType=4,
    MaximumSeconds=TIME_LIMIT
);

sECOS() = ECOSSolver(
    verbose=0
)

sGLPK() = GLPKSolverLP(
#   presolve=true,  # no pre-solve for interior-point (apparently)
    method=:InteriorPoint,
    msg_lev=0,
    # TimeLimit=TIME_LIMIT  # GLPK will ignore time limit for IPM algo
);

sIPOPT() = IpoptSolver(
    print_level=0,
    max_cpu_time=Float64(TIME_LIMIT),
);

sTLP() = Tulip.TulipSolver(
    verbose=0,
    time_limit=TIME_LIMIT,
    barrier_iter_max=200,
    algo=1
);

# Commercial solvers
sCPX() = CplexSolver(
    CPX_PARAM_SCRIND=0,
    CPX_PARAM_PREIND=0,
    CPX_PARAM_THREADS=1,
    CPX_PARAM_LPMETHOD=4, # 0:default, 1:PS, 2:DS, 4:IPM, 6:Concurrent
    CPX_PARAM_SOLUTIONTYPE=2  # 0: default, 1: basic, 2:no crossover,
)

sGRB() = GurobiSolver(
    GRBENV,
    OutputFlag=0,
    Method=2,
    Presolve=0,
    Threads=1,
    Crossover=0
)

sMSK() = MosekSolver(
    MSK_IPAR_INTPNT_BASIS=0,
    MSK_IPAR_NUM_THREADS=1,
    MSK_IPAR_PRESOLVE_USE=0,
    MSK_IPAR_LOG=0,
    MSK_DPAR_OPTIMIZER_MAX_TIME=TIME_LIMIT
);

solver_name(::ClpSolver) = :CLP
solver_name(::ECOSSolver) = :ECOS
solver_name(::GLPKSolverLP) = :GLPK
solver_name(::IpoptSolver) = :IPOPT
solver_name(::TulipSolver) = :TLP
solver_name(::CplexSolver) = :CPX
solver_name(::GurobiSolver) = :GRB
solver_name(::MosekSolver) = :MSK