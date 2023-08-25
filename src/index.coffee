import FS from "node:fs/promises"
import Path from "node:path"
import * as Value from "@dashkite/joy/value"
import YAML from "js-yaml"

cache = {}

read = ( path ) ->
  Value.clone cache[ path ] ?= await do ->
    try
      text = await FS.readFile path, "utf8"
      switch Path.extname path
        when ".yaml", ".yml" then YAML.load text
        when ".json" then JSON.parse text
        else throw new "Unknown file extension for #{ path }" 
    catch
      {}

write = ( path, data ) ->
  unless Value.equal cache[ path ], data
    cache[ path ] = data
    await FS.mkdir ( Path.dirname path ), recursive: true
    FS.writeFile path,
      switch Path.extname path
        when ".yaml", ".yml" then YAML.dump data
        when ".json" then JSON.stringify data
        else throw new "Unknown file extension for #{ path }" 

Zephyr =

  read: ( path ) ->
    data = await read path
    { data, path }

  write: ({ path, data }) -> write path, data

  update: ( path, updater ) ->
    proxy = await @read path
    await updater proxy.data
    @write proxy


export { Zephyr }
export default Zephyr

