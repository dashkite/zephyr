# Testing

## General Approach

The Zephyr module relies on `@dashkite/amen` and `@dashkite/assert` for its test suite. The tests verify functionality by applying operations directly on the file system and subsequently confirming the changes with assertions. Tests create temporary files or modify test artifacts during execution, cleaning them up after verification to ensure a clean state.

## Running Tests

To run the test suite, invoke the `test` command using the Genie task manager:

```shell
npx genie test
```
