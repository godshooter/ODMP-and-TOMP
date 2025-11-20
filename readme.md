# ODMP and TOMP

This repository provides the implementation of two efficient sparse representation algorithms for fault signal processing:

- **ODMP (Orthogonal Dictionary Matching Pursuit)**: A fast alternative to OMP when using orthogonal dictionaries.

- **TOMP (Temporal Orthogonal Matching Pursuit)**: A computationally efficient OMP variant designed for overcomplete wavelet dictionaries with compact support, especially suitable for bearing fault signals.
- **Simulation**:  This folder contains the experimental workflow presented in the manuscript, demonstrating the complete fault diagnosis process for simulated bearing signals. It includes computationally efficient correlation-based parameter identification, dictionary construction, and sparse coefficient solving using TOMP. The simulation also reports the computational time for each stage, providing a clear reference for the efficiency of the proposed methods.

## 📄 Dataset Availability

For the experimental cases described in the sections “Experimental Analysis of Train Bearing Fault Diagnosis at 100 km/h” and “Train Bearing Fault at 150 km/h”, the data cannot be made publicly available due to confidentiality agreements with the cooperating companies.

this repository includes:

- Code and results applied to simulation signals.

- Examples using the publicly available XJTU-SY bearing dataset.

## 🔍 Features

- Fast implementation for sparse signal reconstruction
- Effective suppression of harmonic interference(ODMP)
- Effective extraction of impulsive components from noisy signals(TOMP)
- Validated on simulated and XJTU bearing dataset fault signals

---

## 🚀 Getting Started

1. Clone this repository:

```bash
git clone git@github.com:godshooter/ODMP-and-TOMP.git
cd ODMP-and-TOMP
```

2. Open the `.m` files in MATLAB.

3. Run demo scripts:
```matlab
ODMP\\main.m
TOMP\\Demo_XJTU_11.m,Demo_XJTU_21.m
Simulation\\Demo_sim.m
Simulation\\Demo_full_process.m

---

## 📈 Performance

- **ODMP** achieves a **~98% reduction** in running time compared to classical OMP under orthogonal dictionaries.
- **TOMP** reduces redundant projections under overcomplete wavelet dictionaries, offering substantial speedup in real bearing fault analysis.

