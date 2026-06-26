# Masters-Thesis-Code

This project investigates the dynamic behavior of the ABENICS mechanism using two independent models: an analytical multibody formulation with DAEs and a MotionView/MotionSolve model. Two motion scenarios are simulated using the published geometric control algorithm, and the results of both models are compared to evaluate modeling choices, dynamic consistency, and the physical behavior of the mechanism.

## Workflow Overview
- Analytical DAE simplified model (one sphere and two cylinders) with nonholonomic constraints (two no-slip conditions) and rigid body equations of motion
- MotionView multibody model with one spherical (cross-spherical) output gear and two cylindrical (monopole) actuator gears
- Two motion scenarios formulation (one with a single target-point and one with four successive target-points) based on the geometric control algorithm used in the original ABENICS publications and experiments
- Simulation and dynamic response comparison for both models under identical actuation inputs (constant gear velocities)

## Key Findings
- Control algorithm inconsistencies regarding actuator gear motion, causing slippage between the cylinders and the sphere in the analytical model and tooth‑pressing in the MotionView model
- Highly sensitive analytical DAE model to constraint incompatibilities, compared to robust MotionView model tolerating them but exhibiting increased internal forces
- Better performance for the analytical model when the gear motion is compatible, in contrast with the numerical errors of the MotionView model
- Dynamic application of inconsistent control law reveals important physical effects not captured in purely control kinematic studies
- First dynamic‑focused comparison of ABENICS models under the original control strategy, highlighting limitations in both modeling approaches and in the mechanism’s actuation scheme

## Repository Contents
- `src/`
  - `Python/`
    - `Single_Point_Simulation.py` - numerical integration of the analytical DAE model for simulation of the first scenario
    - `Multiple_Points_Simulation.py` - numerical integration of the analytical DAE model for simulation of the second scenario
  - `Matlab/`
    - `Plots_Single_Point_Comparison.m` - comparison of analytical and MotionView model results for the first scenario
    - `Plots_Mutliple_Points_Comparison.m` - comparison of analytical and MotionView model results for the second scenario
- `data/` - analytical model numerical integration results and MotionView output files

## How to Run
- Run the Python scripts to simulate the analytical DAE model for each scenario
- Run the Matlab comparison scripts to evaluate differences between the analytical and MotionView models
- Plots of generalized coordinates, velocities and accelerations, constraint violations, and internal forces are generated automatically
