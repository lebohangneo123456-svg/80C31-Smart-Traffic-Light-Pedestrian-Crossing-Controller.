# Simulation test plan and verification boundaries

## Evidence supplied

1. North–South RED and East–West GREEN (image 01).
2. Both directions RED and pedestrian WALK lit (image 02).
3. North–South GREEN and East–West RED (image 03).

These are screenshots from the user's Proteus run; their order in the repository is descriptive rather than a continuous timed recording.

## Source-code checks

- `main.asm` was extracted directly from `FIRMWARE/80C31_1/main.asm` inside the submitted `.pdsprj`.
- `Debug.HEX` was extracted directly from `FIRMWARE/80C31_1/Debug/Debug.HEX` inside the project.
- The six unique Port 1 byte patterns correspond to the requested outputs and pedestrian active-LOW wiring.
- The project includes no pedestrian push-button logic; WALK is scheduled automatically.

## Reproducible Proteus test matrix

| Test | Measurement | Expected |
|---|---|---|
| Startup | P1.0 and P1.3 | Both road reds first |
| NS green | P1.2=HIGH, P1.3=HIGH | NS green and EW red |
| NS yellow | P1.1=HIGH, P1.3=HIGH | NS yellow and EW red |
| All red | P1.0=HIGH, P1.3=HIGH | Both road reds |
| EW green | P1.0=HIGH, P1.5=HIGH | NS red and EW green |
| EW yellow | P1.0=HIGH, P1.4=HIGH | NS red and EW yellow |
| Pedestrian phase | P1.0=HIGH, P1.3=HIGH, P1.6=LOW, P1.7=HIGH | Both red and WALK on |
| Pedestrian stop | P1.6=HIGH, P1.7=LOW | WALK off and DON'T WALK on |
| Exclusivity | P1.2 and P1.5 | Never both HIGH |
| Timing | Timer 0 / P1 signals | Nominal phase durations per README |

To capture evidence, use Proteus **logic analyser** probes on P1.0 through P1.7 and set enough time range for the approximately 23-second cycle; a digital scope with four channels can track NS green, EW green, EW yellow, and pedestrian WALK separately.

## Not independently verified

- New build execution in another Proteus installation.
- Measured timer durations, clock calibration, and long-term stability.
- Physical LED/driver currents, power consumption, external EPROM setup on real hardware.
- Industrial fail-safe conflict logic or regulatory compliance.
