# Tracy — Anomaly Detection & Time-Series

**Summary:** How to use time-series databases and anomaly detection as part of Tracy.

- Store metrics & transaction states in a time-series store (InfluxDB, OpenTSDB, Bigtable).
- Configure retention policies per metric to control costs.
- Use ML-driven anomaly detection on metrics like latency, error rate, throughput and dependency latency.
- Example metrics: Request latency, Error rates, Throughput, Resource utilization, Dependency latency.

**Note:** Use the stored traces + metrics to feed anomaly-detection models and generate proactive alerts.
