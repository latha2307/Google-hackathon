# Google-hackathon
# Dynamic Network-on-Chip Optimization with Q-learning

## Project Overview

Traditional NOC configurations often involve static adjustments that may not adapt well to varying workloads. This project explores using Q-learning, a reinforcement learning technique, to create a self-learning monitor that can dynamically adjust NOC configurations (e.g., throttling, buffer allocation) to achieve optimal performance.

The Q-learning algorithm aims to balance conflicting performance goals such as:

- Low latency (fast communication)
- High bandwidth (efficient data transfer)
- Efficient buffer utilization (avoiding overflow)
- Staying within power constraints

By learning from past rewards and penalties, the Q-learning monitor continuously improves its decision-making, leading to an overall improvement in NOC performance.

## Features

- Implements a Q-learning algorithm for dynamic NOC optimization.
- Monitors key performance metrics (latency, bandwidth, buffer occupancy, power consumption).
- Adapts configurations based on the current NOC state and learned Q-values.
- Offers a balance between exploration (trying new actions) and exploitation (using learned best actions).

## Dependencies

- This code snippet assumes a hardware description language (HDL) environment like SystemVerilog for simulation.

## Usage

1. **Integration**: Integrate the provided code (`NOC_design_monitor.sv`) into your NOC design.

2. **Configuration**:
   - Define the specific actions your NOC supports (e.g., throttling levels, buffer allocation adjustments).
   - Adjust the reward function parameters based on your desired optimization priorities.

3. **Simulation**:
   - Simulate various workload scenarios to evaluate the impact of the Q-learning monitor on NOC performance.
   - Compare performance metrics (latency, bandwidth) against a baseline without Q-learning.

## References

- [Reinforcement Learning for Self-Configurable NoC](https://ieeexplore.ieee.org/iel7/9524739/9524720/09524761.pdf) by Kai Zhang et al. (2019): This paper explores the use of deep reinforcement learning for self-configuring Network-on-Chips.
- [Reinforcement Learning Based Fault-Tolerant Routing Algorithm for Mesh Based NoC and Its FPGA Implementation](https://ieeexplore.ieee.org/iel7/6287639/9668973/09760423.pdf) by Xiaoying Shao et al. (2020): This paper proposes a reinforcement learning-based fault-tolerant routing algorithm for mesh-based NOCs.

