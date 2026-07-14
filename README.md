# Zephyr

*Read and write configuration files easily*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Zephyr provides a straightforward approach to managing configuration files, offering caching, parsing, and structured updates.

## Features

- Reads and writes files based on extension.
- Automatically handles JSON and YAML formatting out of the box.
- Provides an internal cache to reduce disk operations.
- Exposes both static and instance-based APIs for flexibility.

## Installation

```shell
pnpm install @dashkite/zephyr
```

## Usage

```coffeescript
import Zephyr from "@dashkite/zephyr"

data = await Zephyr.read "config.yaml"
console.log data.greeting
```

## Other Resources

- [Reference Documentation](docs/reference.md)
- [Usage Guides](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing](docs/testing.md)