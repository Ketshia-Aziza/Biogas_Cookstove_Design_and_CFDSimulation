# Computational Fluid Dynamics (CFD) Analysis of a Household Biogas Burner

![Status](https://img.shields.io/badge/Status-Complete-green)
![Field](https://img.shields.io/badge/Field-Energy%20Engineering-blue)
![Software](https://img.shields.io/badge/Software-ANSYS%20%7C%20MATLAB%20%7C%20SolidWorks-orange)

## 👤 Author & Background
* **Author:** Ketshia Ngalula Aziza
* **Degree:** MSc Energy Engineering (PAUWES)
* **Focus:** Clean Cooking Technology & Computational Modeling

---

## 1. 🎯 Background and Objective
Clean cooking technologies require optimized fuel–air mixing and controlled heat distribution to improve thermal efficiency and reduce pollutant emissions. As part of my Master’s thesis, CFD simulations were conducted to analyze the airflow behavior, thermal fields, and combustion characteristics of a household biogas burner.

**The objectives of this study were:**
* **Dimensioning:** Establish burner geometry using analytical engineering models.
* **Fluid Analysis:** Evaluate fuel–air mixing quality inside the burner (Cold-Flow).
* **Combustion Modeling:** Assess flame stabilization, temperature distribution, and emission performances using CFD.

---

## 2. 🛠️ Methodology & Software Stack
This project integrates parametric design with numerical validation.

| Stage | Software | Function |
| :--- | :--- | :--- |
| **Analytical Design** | MATLAB | Dimensioning of injector, mixing tube, air ports, and the number and configuration of the flame ports. |
| **3D Modeling** | SolidWorks | Generating watertight CAD geometries. |
| **Simulation** | ANSYS Fluent R2025 (student) | CFD Analysis (Mixing & Reacting Flows). |

---

## 3. 🧪 Numerical Setup & Validation Strategy

### 3.1 Mixing Flow (Cold-Flow)
* **Role:** Analyzes the quality of fuel–air mixing.
* **Internal Validation:** The results of the cold-flow simulation were **validated against the analytical design parameters** calculated in MATLAB (e.g., outlet velocity and mass flow rates) to ensure simulation accuracy.

### 3.2 Combustion Simulation (Reacting Flow)
* **Role:** Analyzes flame structure and temperature fields.
* **Computational Method:** Performed within ANSYS Fluent using the Non-premixed combustion model and PDF approach.

### 3.3 External Validation (Literature-Based)
Due to time constraints for direct experimental testing, the CFD simulation results were validated through an **extensive comparative analysis with published results from credible literature**. This involved benchmarking my numerical findings against existing experimental and numerical studies on similar biogas burner designs.

---

## 4. 📊 Results and Interpretation

### 4.1 Cold-Flow Analysis
The simulation confirmed that the analytical dimensions (injector/port sizes) provided a uniform velocity profile, preventing flash-back or lift-off.

### 4.2 Reacting Flow Analysis
The results showed a stable flame anchored near the burner ports:
* **Max Temperature:** **2063 K**, aligned with stoichiometric reaction zones.
* **Emissions:** Localized CO formation with rapid oxidation to CO2, suggesting efficient fuel conversion.
* **CH4 Consumption:** Rapid fuel oxidation immediately above ports, confirming effective burner head design.

---

## 5. 🔗 Integration & Impact
This repository demonstrates the integration of **Parametric Analytical Modeling** and **Advanced CFD Analysis**. It highlights a rigorous approach to engineering validation via literature benchmarking, a critical skill for high-level research in the energy transition.

## 📂 Repository Structure
* `/CAD`: STEP and STL files of the burner geometry.
* `/CFD_Docs`: Detailed walkthrough of the simulation and validation methodology.
* `/Images`: Result contours (Temperature, CO, CO2, O2, CH4).
* `/MATLAB`: Analytical design scripts.
*For more information or collaboration inquiries, feel free to reach out via [LinkedIn](https://www.linkedin.com/in/ketshia-ngalula-aziza-b5b00b122).*
