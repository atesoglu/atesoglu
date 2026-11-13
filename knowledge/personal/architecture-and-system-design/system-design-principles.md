# **System Design**

## **1. Requirement Clarifications**

- **Users/Clients:** Who will use the system? How will the system be used?
- **Scale:**
  - How many reads per second?
  - Are there more writes than reads?
  - Can there be spikes in traffic?
- **Performance:**
  - What is the expected write-to-read data delay?
  - What is the expected p99 latency for reads?
- **Cost:**
  - What is the cost of development?
  - What is the cost of maintenance?

## **2. System Design Components**

### **Step 1: Define the Problem Space**

- Understand the problem and define the scope.
- Clarify functional and non-functional requirements.
- State assumptions and decisions explicitly.

### **Step 2: Design the System at a High Level**

- Design APIs to define how clients access system resources.
- Consider request parameters, response types, and communication between client and server.
- Create a high-level design diagram to illustrate the system architecture.

### **Step 3: Deep Dive into the Design**

- Examine system components and relationships in detail.
- Consider the impact of non-functional requirements on design choices.
- Present different design options with their pros and cons.

### **Step 4: Identify Bottlenecks and Scaling Opportunities**

- Assess the system's ability to operate under various conditions and support growth.
- Address:
  - Single points of failure.
  - Data replication and sharding.
  - Global service support.
  - Scalability (CDN and caching).
- Consider concepts such as:
  - Horizontal sharding.
  - CDN.
  - Caching.
  - Rate limiting.
  - Databases.

### **Step 5: Review and Wrap Up**

- Summarize major decisions with justifications and trade-offs.
- Ensure the design satisfies all requirements.
- Identify directions for further improvement.

## **3. CAP Theorem**

**A system cannot provide all three guarantees simultaneously.**

### **Consistency (C)**

Every read receives the most recent successful write, or an error.

All nodes behave as though there is a single, up-to-date copy of the data.

### **Availability (A)**

Every request received by a non-failing node eventually receives a valid response, even if that response cannot contain the latest data.

### **Partition Tolerance (P)**

The system continues operating despite network communication failures that prevent some nodes from communicating with others.
