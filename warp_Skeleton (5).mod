###################################################
#### Write your names and student numbers here ####

#Reezwan-Us Sami 1007767141
#Gurleen Kaur Virdi 1009135240


###################################################
## Define your sets here

set Products;
set RawMaterials;
set Machines;
#set Year;
set Warehouse;
set Months := 1..12;

###################################################
## Define your parameters here

# Sales price per product type from Product Master Table
param SalesPrice{Products};

# Raw material cost per product from RM Master Table
param RawMatCost{Products};

# Estimated demand for each product type
param EstimatedDemand{Products, Months};

# Cost of not meeting the demand per product type
param UnmetDemandCost := 10; # Given as $10/pair in the problem statement

# Labor cost per hour
param LaborCost := 25; # Given as $25/hour in the problem statement

param Budget := 10000000; # $10,000,000 budget for raw materials
# Labor hours required per product, assumed to be provided
param LaborHours{Products};

# 'RawMatAvailability' gives the available quantity of each raw material
param RawMatAvailability{RawMaterials};

# 'RawMatUsage' gives the amount of each raw material used for each product
param RawMatUsage{Products, RawMaterials};

param MachineHours{Machines};

# 'ProdMachineTime' gives the processing time (in seconds) for each product on each machine
param ProdMachineTime{Products, Machines};

param NumberOfMachines{Machines};

param MachineCost{Machines};

param TotalWarehouseCapacity{Warehouse}; # To be defined based on Warehouse_Master data

#param TempDemand{Products, Months};


#param FebruaryDemand{Products};

#param HistoricalDemand{Products, Year};

###################################################
## Define your decision variables here
# Number of shoes produced of each type
var Production{Products} >= 0;

###################################################
## Define your objective function here
# Objective: Maximize profit by maximizing revenue and minimizing costs (material, labor, unmet demand)
maximize TotalProfit:
    sum{p in Products} ((SalesPrice[p] * Production[p]) 
    - (RawMatCost[p] * Production[p])
    - sum {m in Machines}(MachineCost[m] * ProdMachineTime[p,m])
    - (LaborCost * LaborHours[p] * Production[p])
    - sum {t in Months}(UnmetDemandCost * max(0, EstimatedDemand[p,t] - Production[p])));

###################################################
## Define your constraints here
# Constraint: Do not exceed the budget for raw materials
# Declaration of parameters


# Constraints
subject to RawMaterialBudget:
    sum{p in Products} (RawMatCost[p] * Production[p]) <= Budget;

# Constraint: Do not exceed labor hours available
param TotalLaborHours := sum{m in Machines}(12 * 28 * NumberOfMachines[m]); # 12 hours a day, 28 days a month, for each machine

subject to LaborHoursLimit:
    sum{p in Products} (LaborHours[p] * Production[p]) <= TotalLaborHours;

# Constraint: Warehouse capacity
subject to WarehouseCapacityLimit:
    sum{p in Products} Production[p] <= sum{w in Warehouse}TotalWarehouseCapacity[w];

# Constraint: Meet the estimated demand for each product
subject to DemandFulfillment{p in Products}:
    Production[p] >= sum{t in Months}EstimatedDemand[p,t];

# Assume that 'Machines' is the set of all machines
# 'MachineHours' gives the number of hours each machine can operate



# Constraint: Do not exceed machine hours available for each machine
subject to MachineHoursLimit{m in Machines}:
    sum{p in Products} (ProdMachineTime[p, m] * Production[p]) / 3600 <= MachineHours[m]; # Convert seconds to hours

# Constraint: Do not exceed raw material availability
subject to RawMaterialAvailabilityLimit{r in RawMaterials}:
    sum{p in Products} (RawMatUsage[p, r] * Production[p]) <= RawMatAvailability[r];


					