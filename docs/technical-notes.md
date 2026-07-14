# Technical Notes

### Caching and Memoization

Zephyr implements an internal cache for read operations. This represents a form of memoization, a computer science technique used to store the results of expensive operations (like disk I/O or parsing) and return the cached result when the same inputs occur again. This reduces latency and disk overhead when the same configuration file is accessed multiple times across an application's lifecycle.

### File System Atomicity

While Zephyr manages file writes and directories, it relies on standard asynchronous file system operations rather than strictly atomic writes. This means concurrent writes to the same file could potentially lead to race conditions or corrupted states if a write fails mid-operation. Developers managing highly concurrent environments should consider implementing external locking mechanisms or relying on appropriate database systems instead of flat files.

### Object Mutation and Caching

The internal cache stores references to the parsed data objects. If a developer modifies an object returned by `Zephyr.read` and does not call `Zephyr.write`, the cached version is mutated, but the disk file remains unchanged. This can lead to unexpected states where the application believes the data has been saved. Always use `Zephyr.update` or explicitly call `Zephyr.write` to ensure disk consistency.
