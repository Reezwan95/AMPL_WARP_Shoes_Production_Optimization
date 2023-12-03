# AMPL_WARP_Shoes_Production_Optimization
AMPL program with Gurobi solver to Maximize Profit of WARP Shoe Company

The program contains 3 files:
-.mod file: models the problem through sets, parameters, decision variable, the objective function to optimize and the constraints
-.dat file: reads and stores the data for the sets and parameters from .mdb database using SQL queries
-.run file: runs the program by compiling the .mod and .dat files, displays the optimal values, shadow price and reduced costs to the console
