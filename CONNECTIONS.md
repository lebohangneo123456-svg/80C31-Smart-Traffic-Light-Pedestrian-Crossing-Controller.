# Circuit wiring summary — 80C31 with external ROM

This documents the **submitted Proteus schematic**, not a certified hardware schematic.

## Microcontroller supply, clock and reset

- 80C31 VCC pin 40 → +5 V; GND pin 20 → GND (may be hidden power pins in the model).
- 12 MHz crystal across XTAL1 pin 19 and XTAL2 pin 18.
- Each crystal terminal → 22 pF capacitor → GND.
- RST pin 9 → 10 kΩ → GND; 10 µF capacitor from +5 V to RST, positive toward +5 V.
- `/EA` pin 31 → GND for external-only program memory.

## Latch — 74HC373

| 80C31 | 74HC373 |
|---|---|
| P0.0 / pin 39 | D0 / pin 3 |
| P0.1 / pin 38 | D1 / pin 4 |
| P0.2 / pin 37 | D2 / pin 7 |
| P0.3 / pin 36 | D3 / pin 8 |
| P0.4 / pin 35 | D4 / pin 13 |
| P0.5 / pin 34 | D5 / pin 14 |
| P0.6 / pin 33 | D6 / pin 17 |
| P0.7 / pin 32 | D7 / pin 18 |
| ALE / pin 30 | LE / pin 11 |
| GND | `/OE` / pin 1 |

Latch Q0–Q7 → 27C64 address A0–A7 respectively.

## EPROM — 27C64

- P0.0–P0.7 also connect to EPROM D0–D7 (multiplexed data bus).
- P2.0–P2.4 → EPROM A8–A12.
- `/PSEN` pin 29 → EPROM `/OE` pin 22.
- EPROM `/CE` pin 20 → GND.
- EPROM `/PGM` pin 27 and VPP pin 1 → +5 V for ordinary read mode (check selected part's datasheet).
- Power pins → +5 V / GND as specified by the chip model.

## Signals and pedestrian LEDs

- P1.0–P1.2 = North–South R/Y/G.
- P1.3–P1.5 = East–West R/Y/G.
- Discrete WALK LED: +5 V → resistor → LED anode → LED cathode → P1.6 (LOW = ON).
- Discrete DON'T WALK LED: +5 V → resistor → LED anode → LED cathode → P1.7 (LOW = ON).

In **physical circuitry**, do not assume the simulated 330 Ω resistor is appropriate for the 80C31 output current. Use adequately sized resistors or driver stages based on the specific microcontroller current ratings and desired LED current.
