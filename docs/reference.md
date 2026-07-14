# Zephyr API Reference

## Class: Zephyr

### clear

$clear: \to \emptyset$

Clears the internal file contents cache. 

### make

$make: path \to instance$

Creates a `Zephyr` instance bound to a specific file path.

### exists (static)

$exists: path \dashrightarrow boolean$

Checks if a file exists on disk.

```coffeescript
hasConfig = await Zephyr.exists "config.yaml"
```

### read (static)

$read: path \dashrightarrow data$

Reads file contents, caching and parsing based on the file extension.

```coffeescript
config = await Zephyr.read "config.yaml"
```

### write (static)

$write: path, data \dashrightarrow \emptyset$

Writes data to a file on disk, updating the cache and creating directories if they do not exist.

### update (static)

$update: path, updater \dashrightarrow \emptyset$

Updates file contents using an updater function. It reads the current data, applies the updater, and writes the result.

```coffeescript
await Zephyr.update "config.yaml", ( data ) ->
  Object.assign data, newSettings
```

### remove (static)

$remove: path \dashrightarrow \emptyset$

Deletes a file from disk.

### invalidate (static)

$invalidate: path \to \emptyset$

Removes a specific file path from the cache.

### register

$register: extension, handlers \to \emptyset$

Registers a custom parser and formatter for a specific file extension.

### exists

$exists: \dashrightarrow boolean$

Checks if the bound file exists.

### read

$read: \dashrightarrow data$

Reads the bound file's contents.

### write

$write: data \dashrightarrow \emptyset$

Writes data to the bound file.

### update

$update: updater \dashrightarrow \emptyset$

Updates the bound file's contents using the provided function.

### remove

$remove: \dashrightarrow \emptyset$

Deletes the bound file.

### invalidate

$invalidate: \to \emptyset$

Removes the bound file from the cache.

### path

$path \to string$

The file path associated with the `Zephyr` instance.
