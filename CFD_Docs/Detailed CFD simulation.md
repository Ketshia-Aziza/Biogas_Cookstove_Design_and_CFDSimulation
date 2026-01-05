# Computational Fluid Dynamics Analysis of a Household Biogas Burner

**Author:** Ketshia Ngalula Aziza  
**Degree:** MSc Energy Engineering  
**Software:** ANSYS Fluent R2025 (Student Version), SolidWorks, MATLAB  

---

## 1. Purpose of the CFD Study

This document provides a detailed description of the Computational Fluid Dynamics (CFD) simulations conducted to analyze the performance of a household biogas burner. The simulations were carried out as part of my Master’s thesis work and were used to validate analytical burner design calculations and to assess flow mixing, combustion behavior, and thermal characteristics.

This document complements the repository README by focusing exclusively on the **CFD modeling methodology and results**.

---

## 2. Geometry Definition and Computational Domains

The burner geometry was developed in **SolidWorks** based on design parameters obtained from analytical calculations implemented in MATLAB. These parameters include injector dimensions, mixing tube length, air port size, and burner head characteristics.
![Figure 1: Three-dimensional CAD model of the biogas burner geometry.](/Image/CAD_Model.png)


Two CFD computational domains were derived from the three-dimensional burner geometry:

- **Mixing Flow Domain:** Used to analyze non-reacting air–fuel mixing inside the burner.
  ![Figure 2: Three-dimensional CFD model render for mixing flow](/Image/FluidDomain1.png)

- **Combustion Domain:** A simplified domain focusing on the region above the burner head where combustion occurs.
![Figure 3: Three-dimensional CFD model render for combustion ](/Image/Fluidomain2.png)

This two-domain approach allows separation of cold-flow mixing analysis from reacting flow simulation.

---

## 3. Mesh Generation and Quality Assessment

Meshing was performed using **ANSYS Fluent Meshing** for watertight geometry. A **polyhedral hex-core volume mesh** was adopted to balance numerical accuracy and computational efficiency.

Local mesh refinement was applied in:
- Fuel and air inlet regions
- Flame stabilization and combustion zones

### Mesh Quality Indicators

**Mixing Flow Domain:**
- Total number of cells: ~369,000  
- Maximum skewness: 0.65  
- Minimum orthogonal quality: 0.20  
- No isolated cells detected  
![Figure 4: Computational mesh of the burner domain highlighting refinement regions.](/Image/Mixing flow mesh.png)

**Combustion Domain:**
- Total number of cells: ~287,000  
- Maximum skewness: 0.52  
- Minimum orthogonal quality: 0.29  
- No isolated cells detected  
![Figure 5: Computational mesh of the combustion domain highlighting refinement regions.](/Image/Combustion_mesh_network.png)
These values are within acceptable limits for RANS-based combustion simulations.

---

## 4. Numerical Models and Solver Strategy

The CFD simulations were conducted in **two sequential stages**.

---

### 4.1 Cold-Flow Mixing Simulation (Non-Reacting)

The first stage focused on evaluating the mixing quality of biogas and air prior to ignition.

**Model configuration:**
Table 1. Solver and physical models for cold-flow simulation
| Parameter | Setting |
|-----------|---------|
| Solver type | Pressure-based |
| Flow regime | Steady-state |
| Energy equation | Enabled |
| Species transport | Enabled (non-reacting) |
| Turbulence model | Realizable *k–ε* |
| Turbulence treatment | Standard wall functions |

**Boundary conditions:**
Table 2. Boundary conditions for cold-flow simulation
| Boundary | Type | Specification |
|----------|------|---------------|
| Fuel inlet | Mass flow inlet | Biogas (60% CH₄, 40% CO₂) |
| Air inlet | Mass flow inlet | Air (21% O₂, 79% N₂) |
| Outlet | Pressure outlet | Atmospheric pressure |
| Walls | No-slip | Adiabatic |


The outputs of this simulation—specifically outlet velocity and species composition—were used as inlet conditions for the combustion simulation.

---

### 4.2 Combustion Simulation (Reacting Flow)

The second stage simulated combustion in the simplified burner-head domain, assuming uniform flow distribution at the flame ports.

**Model configuration:**
Table 3. Solver and physical models for combustion simulation
| Parameter | Setting |
|-----------|---------|
| Solver formulation | RANS |
| Solver type | Pressure-based |
| Flow regime | Steady-state |
| Turbulence model | Realizable *k–ε* |
| Combustion model | Non-premixed combustion |
| Turbulence–chemistry interaction | PDF approach |
| Radiation model | P1 |
| Energy treatment | Non-adiabatic |
| Flammability limit | 10% above stoichiometric mixture fraction |
  

**Boundary conditions:**
Table 4. Boundary conditions for combustion simulation  
| Boundary | Type | Specification |
|----------|------|---------------|
| Fuel inlet | Velocity inlet | From cold-flow simulation results |
| Secondary air inlet | Pressure inlet | Reverse flow prevented |
| Outlet | Pressure outlet | Atmospheric pressure |
| Walls | No-slip | Heat transfer enabled |

---

## 5. Results and Interpretation

### 5.1 Mixing Flow Results

Species contours for methane and oxygen indicate effective air–fuel mixing within the mixing tube. The velocity distribution at the burner exit is sufficiently uniform, suggesting favorable conditions for flame stabilization and combustion initiation.
![Figure 6: Oxygen Contour.](/Image/mixingflow_OxygenContour.png)

![Figure 7: Methane Contour.](/Image/mixingflow_methaneContour.png)

---

### 5.2 Combustion Results

The combustion simulations reveal a stable and well-structured flame.

- **Temperature field:** Maximum flame temperature reaches approximately **2063 K**, with combustion occurring primarily within the stoichiometric reaction zone.
![Figure 8: Temperature Contour.](/Image/Temperature_Contour.png)
- **Oxygen (O₂):** Depletion near the burner head confirms active combustion, followed by recovery downstream.
![Figure 9: Oxygen Contour.](/Image/O2_Contour.png)
- **Carbon dioxide (CO₂):** Concentrated production in the post-flame region indicates complete combustion.
![Figure 10: Carbon dioxide Contour.](/Image/CarbonDioxide_Contour.png)
- **Carbon monoxide (CO):** Localized formation near the flame front with rapid downstream oxidation, suggesting efficient conversion to CO₂.
![Figure 11: Carbon monoxide Contour.](/Image/CarbonMonoxide_contour.png)
- **Methane (CH₄):** Rapid decrease in fuel concentration above the burner ports confirms effective mixing and oxidation.
![Figure 12: Methane Contour.](/Image/methane_Contour.png)

Overall, the CFD results support the analytical burner design and validate the selected configuration.

---

## 6. Model Limitations

While the simulations provide meaningful insights, several limitations should be noted:

- Use of a simplified PDF-based combustion model with default methane–air reaction kinetics
- Idealized biogas composition (60% CH₄, 40% CO₂)
- Steady-state RANS formulation
- A lake of experimental data to validate the combustion results

Future work could include detailed chemistry mechanisms, transient simulations, and experimental validation.

---

## 7. Role of CFD in the Design Workflow

The CFD analysis was used as a **design validation and refinement tool**, complementing analytical calculations and supporting systematic selection of burner configurations before experimental implementation.

---

*This document is shared for academic demonstration purposes only and does not constitute a published work.*

