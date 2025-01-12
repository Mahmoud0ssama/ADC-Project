# Analog & digital communication -Project

## Part 1: Signal Processing and Constellation Diagrams

### Operations:
- Calculates basis functions and coefficients using the trapezoidal rule.
- Plots the input signals (si), basis functions (phi_j), and signals after subtracting contributions from other basis functions (gi).
- Plots the constellation diagram based on the calculated coefficients (sij).
- Calculates the energy of each symbol using the constellation diagram.

## Part 2: Communication System Simulation

### Operations:
- Plots the polar NRZ binary signal.
- Introduces additive white Gaussian noise (AWGN) to the encoded signal at different signal-to-noise ratios (SNR).
- Plots the constellation diagram after adding noise for various SNR values.
- Computes the bit error rate (BER) for different SNR values.
- Compares the practical BER with the theoretical BER using the Q-function.
- Plots the practical and theoretical BER against the signal-to-noise ratio in dB.

## Functions

### `plotting` Function:
- Description: A function designed to plot waveforms stored in a matrix.
- Functionality:
  - Creates a new figure and loops through each row of the matrix to plot the waveforms in separate subplots.
  - Each waveform is plotted using a different color specified by the colorNames array.
  - Adds labels, title, and grid to each subplot.

### `pnrz` Function:
- Description: Implements polar non-return-to-zero (PNRZ) encoding.
- Functionality:
  - Returns the overall PNRZ signal x and the matrix X containing individual bit signals.
