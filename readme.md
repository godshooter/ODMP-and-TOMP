# ODMP and TOMP

This repository provides the implementation of two efficient sparse representation algorithms for fault signal processing:

- **ODMP (Orthogonal Dictionary Matching Pursuit)**: A fast alternative to OMP when using orthogonal dictionaries.
- **TOMP (Temporal Orthogonal Matching Pursuit)**: A computationally efficient OMP variant designed for overcomplete wavelet dictionaries with compact support, especially suitable for bearing fault signals.

---

## 🔍 Features

- Fast implementation for sparse signal reconstruction
- Effective suppression of harmonic interference
- Support for both orthogonal and overcomplete dictionaries
- Validated on simulated and real-world bearing fault signals

---

## 📂 Structure

```bash
ODMP-and-TOMP/
│
├── ODMP/              # ODMP implementation with test cases
├── TOMP/              # TOMP implementation with Laplace wavelet dictionaries
├── data/              # (Optional) Sample vibration signals
├── figures/           # Output figures for publications or demonstration
├── README.md          # Project introduction
└── LICENSE            # License (MIT by default, or change accordingly)
```

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
run_ODMP_example.m
run_TOMP_example.m
```

---

## 🧪 Requirements

- MATLAB R2020 or later
- Signal Processing Toolbox

---

## 📈 Performance

- **ODMP** achieves a **~98% reduction** in running time compared to classical OMP under orthogonal dictionaries.
- **TOMP** reduces redundant projections under overcomplete wavelet dictionaries, offering substantial speedup in real bearing fault analysis.

---

## 📖 Reference

If you find this work useful in your research, please cite:

```bibtex
@article{your_citation_info,
  title={Fast Sparse Representation via ODMP and TOMP for Fault Diagnosis},
  author={Yuan, ...},
  journal={...},
  year={2025}
}
```

---

## 📬 Contact

For questions, feel free to open an issue or email: `your_email@example.com`
