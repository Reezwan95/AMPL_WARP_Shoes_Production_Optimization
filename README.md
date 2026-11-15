# WARP Shoes: production planning with linear programming (AMPL + Gurobi)

This is a profit-maximizing production model for a fictional shoe manufacturer, WARP Shoe Company. It is written in AMPL and solved with Gurobi. The model decides how much of each product to make, given capacity and resource limits. It then reports shadow prices and reduced costs, which show which constraints are worth relaxing and which products are worth reconsidering.

## Files

| File | Purpose |
|---|---|
| `warp_Skeleton.mod` | The model: sets, parameters, decision variables, the profit objective and the constraints |
| `warp_Skeleton.dat` | Loads sets and parameters from the company's `.mdb` database using SQL queries |
| `warp_Skeleton.run` | Compiles the model and data, solves with Gurobi, and prints the optimal values, **shadow prices** and **reduced costs** |

## Run it

With AMPL and Gurobi installed, and the `.mdb` database the `.dat` file points to in place:

```
ampl warp_Skeleton.run
```

## What it shows

- Formulating a real planning problem as a linear program.
- Separating the model from the data, and loading data from a database rather than hard-coding it.
- Sensitivity analysis:
  - **Shadow prices** show the profit gained per extra unit of a scarce resource.
  - **Reduced costs** show how much a product's profit would have to improve before it enters the plan.

Built for an operations research course in the Industrial Engineering program at the University of Toronto.

---
Reezwan-Us Sami · [Portfolio](https://reezwan95.github.io)
