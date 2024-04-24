module NOC_design_monitor(
  // Inputs
  input logic clk,
  input logic [31:0] rd_addr,
  input logic [31:0] wr_addr,
  input logic [31:0] data,
  input logic rd_valid,
  input logic wr_valid,
  input logic [7:0] buffer_id,
  input logic [1:0] agent_type, // 0: CPU, 1: IO
  input logic power_limit_threshold,
 
  // Outputs
  output logic [31:0] rd_latency,
  output logic [31:0] wr_latency,
  output logic [31:0] measured_bandwidth,
  output logic [7:0] buffer_occupancy,
  output logic [1:0] arbitration_rate
);

// Define internal variables
logic [31:0] rd_timestamp;
logic [31:0] wr_timestamp;
logic [31:0] total_rd_latency;
logic [31:0] total_wr_latency;
logic [31:0] total_data_transferred;
logic [31:0] total_cycles;
logic [31:0] total_buffer_occupancy;
logic [31:0] total_power_threshold_exceeded_cycles;
logic [31:0] total_throttling_cycles;
logic [31:0] power_threshold_exceeded;
logic [31:0] throttling_cycles;

// Constants for optimization criteria
localparam MIN_LATENCY = 100; // Minimum latency requirement
localparam MAX_BANDWIDTH = 1000; // Maximum bandwidth requirement
localparam BUFFER_OCCUPANCY_THRESHOLD = 90; // Buffer occupancy threshold
localparam THROTTLING_PERCENTAGE = 5; // Throttling percentage requirement

// Q-learning parameters
localparam ALPHA = 0.1; // Learning rate
localparam GAMMA = 0.9; // Discount factor

// Q-learning state and action variables
logic [31:0] q_state;
logic [31:0] q_action;
logic [31:0] q_value[0:1][0:1]; // Q-value table for states and actions

// Initialize Q-values
initial begin
  q_value[0][0] = 0; // Q-value for state 0, action 0
  q_value[0][1] = 0; // Q-value for state 0, action 1
  q_value[1][0] = 0; // Q-value for state 1, action 0
  q_value[1][1] = 0; // Q-value for state 1, action 1
end

// Q-learning algorithm
always_ff @(posedge clk) begin
  // Determine the current state based on conditions
  if (rd_valid && wr_valid) begin
    q_state = 1;
  end else begin
    q_state = 0;
  end
  
  // Select an action based on Q-values (exploration vs. exploitation)
  if ($urandom() % 100 < 10) begin
    // Explore: Randomly select an action
    q_action = $urandom() % 2;
  end else begin
    // Exploit: Select the action with the highest Q-value for the current state
    if (q_value[q_state][0] > q_value[q_state][1]) begin
      q_action = 0;
    end else begin
      q_action = 1;
    end
  end
end

// Separate block for Q-value update
always_comb begin
  // Calculate reward based on action and optimization criteria
  logic [31:0] reward;
  reward = 0;
  if (rd_latency <= MIN_LATENCY && wr_latency <= MIN_LATENCY &&
      measured_bandwidth >= 0.95 * MAX_BANDWIDTH &&
      buffer_occupancy >= BUFFER_OCCUPANCY_THRESHOLD &&
      (throttling_cycles * 100) / total_cycles <= THROTTLING_PERCENTAGE)begin
        reward = 100;
    end
end

endmodule
