# Usage Guides

## Reading and Updating Configuration

Developers often need to read a configuration file, apply changes, and write it back. Zephyr provides the `update` method to manage this workflow concisely.

The `update` method handles reading the current data, applying an update function, and saving the result back to disk.

```coffeescript
import Zephyr from "@dashkite/zephyr"

# fetch updated details from an external service
newSettings = fetchSettings()

await Zephyr.update "config.yaml", ( data ) ->
  Object.assign ( data ? {} ), newSettings
```

Algorithm for creators:
1. Call `Zephyr.update` with the path to the configuration file.
2. Provide an updater function that receives the parsed file data.
3. Handle the case where the file might be empty or missing by providing a fallback (e.g. `{}`).
4. Modify the data inside the function and return it.
5. Zephyr automatically writes the modified data back to the file on disk.

## Managing Multiple Files

When working with multiple configuration files, developers can create dedicated `Zephyr` instances bound to specific file paths.

```coffeescript
import Zephyr from "@dashkite/zephyr"

configFile = Zephyr.make "config.yaml"
stateFile = Zephyr.make "state.json"

config = await configFile.read()
# perform application setup logic
await stateFile.write status: "initialized"
```

Algorithm for creators:
1. Call `Zephyr.make` with the file path to create an instance.
2. Use instance methods like `read`, `write`, and `update` without needing to pass the file path again.
3. Access the bound file path via the `path` property if needed.
