# Plugin Architecture in Go

**Summary:** Notes on plugin-based designs: compile-time vs runtime plugins, trade-offs and pros/cons.

## What are Plugins?
Plugins are components that can be loaded to extend system functionality at compile or runtime.

## Types
- Compile Time Plugins: Compiled into the binary; functionality fixed at build time.
- Runtime Plugins: Shared libraries / dynamic modules loaded at runtime.

## Pros & Cons
- Pros: modularity, upgradability, smaller memory footprint when loading selectively.
- Cons: added complexity, security concerns, versioning and compatibility challenges.
