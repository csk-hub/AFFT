# TPE-FFT: A Two-Phase Execution Strategy for Low-Latency FFT-Based Sequential Genomic Signal Processing

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2021a%2B-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Release](https://img.shields.io/badge/Release-v1.0.0-green.svg)](https://github.com/csk-hub/AFFT/releases/tag/v1.0.0)

This repository contains the official MATLAB implementation and experimental evaluation scripts for **Two-Phase Execution Fast Fourier Transform (TPE-FFT)**, a dependency-aware execution strategy for radix-2 Decimation-in-Time (DIT) FFT processing applied to sequential genomic signals.

---

## 📌 Overview

Conventional block-oriented Fast Fourier Transforms (FFTs) generally require the complete input sequence to be available before computation can finish. When genomic sequence data are acquired sequentially, operations dependent on the final sample remain unresolved, creating post-arrival processing latency.

**TPE-FFT** addresses this dependency by leveraging Discrete Fourier Transform (DFT) linearity:
* **Phase I (Pre-Arrival):** Computations independent of the final acquired sample are executed in advance using a temporary zero-substitution.
* **Phase II (Post-Arrival Correction):** Once the final sample $x[N-1]$ arrives, its spectral contribution is evaluated and incorporated through an exact Fourier-domain correction.

This strategy substantially reduces the post-arrival computational workload while maintaining the underlying $\mathcal{O}(N \log_2 N)$ FFT complexity.

---

## 📊 Key Findings

Evaluating TPE-FFT across 1,075 human retinal gene sequence datasets from NCBI GenBank demonstrates[cite: 1]:
* **97.95% Success Rate:** 1,053 out of 1,075 sequences showed positive runtime reductions[cite: 1].
* **96.54% Aggregate Time Reduction:** Cumulative execution time dropped from 225.56s to 7.80s ($28.92\times$ runtime ratio)[cite: 1].
* **Large Sequence Efficiency:** For sequence `NM_013231.6` ($33,681$ samples zero-padded to $M = 65,536$), execution time decreased from $15.15\text{ s}$ to $0.51\text{ s}$ ($96.63\%$ reduction)[cite: 1].

---

## 🛠️ Requirements & Computational Environment

* **Software:** MATLAB R2021a or higher (benchmarked on MATLAB 2025b)[cite: 1].
* **Operating System:** Windows 10 / Linux / macOS[cite: 1].
* **Hardware:** Tested on an Intel Core i7 processor with 8 GB RAM[cite: 1].

---

## 🚀 Reproduction Instructions

Follow these steps to reproduce the sequence-level experiments and statistical results reported in the manuscript:

### 1. Clone the Repository
```bash
git clone [https://github.com/csk-hub/AFFT.git](https://github.com/csk-hub/AFFT.git)
cd AFFT
