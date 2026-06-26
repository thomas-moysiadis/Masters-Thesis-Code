# Masters-Thesis-Code

This project investigates the dynamic behavior of the ABENICS mechanism using two independent models: an analytical multibody formulation with DAEs and a MotionView/MotionSolve model. Two motion scenarios are simulated using the published geometric control algorithm, and the results of both models are compared to evaluate modeling choices, dynamic consistency, and the physical behavior of the mechanism.

## Workflow Overview
- Analytical DAE simplified model (one sphere and two cylinders) with nonholonomic constraints (no slip condition) and rigid body kinematics
- MotionView multibody model with one spherical (cross-spherical) output gear and two cylindrical (monopole) actuator gears
- Two motion scenarios formulation (one with a single target-point and one with four successive target-points) based on the geometric control algorithm used in the original ABENICS publications and experiments
- Simulation and comparison with dynamic response evaluation for both models under identical actuation inputs

## Key Findings
- Control algorithm inconsistencies regarding actuator gears motion, causing slippage between the cylinders and the sphere in the analytical model and tooth‑pressing in the MotionView model
- Highly sensitive analytical DAE model to constraint incompatibilities, compared to robust MotionView model tolerating them but exhibiting increased internal forces
- Better performance for the analytical model when the motion is consistent, in contrast with the numerical errors of the MotionView model
- Consistent actuation yields clean dynamics, but the inconsistent control law reveals important physical effects not captured in purely kinematic studies
- First dynamic‑focused comparison of ABENICS models under the original control strategy, highlighting limitations in both modeling approaches and in the mechanism’s actuation scheme

## Repository Contents
- `src/`
  - `Python/`
    - `Single_Point_Simulation.py` - numerical integration of the analytical DAE model for simulation of the first scenario
    - `Multiple_Points_Simulation.py` - numerical integration of the analytical DAE model for simulation of the second scenario
  - `Matlab/`
    - `Plots_Single_Point_Comparison.m` - comparison of analytical and MotionView results for the first scenario
    - `Plots_Mutliple_Points_Comparison.m` - comparison of analytical and MotionView results for the second scenario
- `data/` - 
