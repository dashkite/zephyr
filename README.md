# Zephyr

*Read/write configuration files easily*

## Installation

```
pnpm add @dashkite/zephyr
```

## Usage

```coffeescript
data = await Zephyr.read "test/test.yaml"
assert.equal data.greeting, "Hello, world!"
```

## Zephyr API Reference

Zephyr is a library for reading and writing configuration files.

### Class: Zephyr

#### Static Methods

- `clear` - Clears the file contents cache.
- `make` - Creates a `Zephyr` instance for a file path.
- `register` - Registers parse/format handlers. 
- `exists` - Checks if a file exists.
- `read` - Reads file contents.
- `write` - Writes file contents.
- `update` - Updates file contents.
- `remove` - Deletes a file.

#### Instance Properties

- `path` - The file path associated with this instance.

### Methods

#### exists
- **Description:** Determine whether a given file exists on disk.
- **Parameters:**
  - `path` - File path to read from.  
- **Returns:** A promise resolving to `true` if the file exists, `false` otherwise.

#### read
- **Description:** Reads file contents from disk, caching and reusing existing cache values.
- **Parameters:**
  - `path` - File path to read from.  
- **Returns:** A promise resovling to the file contents parsed using handlers for the given file extension.

#### write
- **Description:** Writes data to a file on disk, updating the cache.
- **Parameters:**
  - `path` - File path to write to.
  - `data` - Data to write to the file.
- **Returns:** a promise that resolves when the file has been written.

#### remove 
- **Description:** Deletes a file from disk.
- **Parameters:**
  - `path` - Path of the file to delete.
- **Returns:** A promise that resolves when the file has been deleted.