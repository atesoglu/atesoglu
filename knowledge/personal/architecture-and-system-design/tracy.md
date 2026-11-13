# Tracy: Unified Observability Platform

Tracy is a proposed platform-level monitoring and tracing layer for services such as shopping, payment, and backoffice. Its purpose is to provide unified visibility across services, improve incident detection and troubleshooting, and enable entity-based tracing of a booking through the entire platform.

## Problem

Teams currently monitor per service. There is no unified view and no entity-based trace of a flight booking across the platform, which makes cross-service bottlenecks and incident diagnosis harder than they should be.

## Objective

Introduce a tracing and observability layer that detects bottlenecks, provides per-transaction visibility, and enables faster incident response.

## Tracing Tools

- **Zipkin:** Lightweight distributed tracing.
- **Jaeger:** End-to-end tracing with visualization and sampling.
- **Lightstep:** Commercial, ML-assisted tracing.
- **Appdash:** Tracing for Go applications.
- **Datadog:** Integrated monitoring and tracing.

Use these tools to instrument services, capture spans for entities such as a flight booking, and visualize service interactions to find latency sources.

## Anomaly Detection and Time-Series Data

- Store metrics and transaction states in a time-series store such as InfluxDB, OpenTSDB, or Bigtable.
- Configure retention policies per metric to control costs.
- Use ML-driven anomaly detection on metrics such as latency, error rate, throughput, and dependency latency.
- Example metrics: request latency, error rates, throughput, resource utilization, and dependency latency.

Feed the stored traces and metrics into anomaly-detection models to generate proactive alerts.

## Implementation Plan

1. **Analysis and assessment:** Inventory existing telemetry such as Prometheus, ELK, and Grafana.
2. **Instrumentation:** Add tracing spans and entity IDs to services.
3. **Data pipeline:** Stream traces and metrics into the tracing backend and time-series database.
4. **Dashboards and alerts:** Build entity-based views and anomaly alerts.
5. **Training and rollout:** Train teams and gradually adopt Tracy for incident response.
6. **Ongoing maintenance:** Review retention, sampling, and model accuracy periodically.
