import FS from "node:fs/promises"
import Path from "node:path"
import * as Value from "@dashkite/joy/value"
import YAML from "js-yaml"

formats =
  ".json":
    parse: ( text ) -> JSON.parse text
    format: ( data ) -> JSON.stringify text, null, 2
  ".yaml": _yaml =
    parse: ( text ) -> YAML.load text
    format: ( data ) -> YAML.dump data
  ".yml": _yaml

register = ( extension, handlers ) ->
  formats[ extension ] = handlers

cache = {}

read = ( path ) ->
  if ( handlers = formats[ Path.extname path ] )?
    Value.clone cache[ path ] ?= await do ->
      try
        text = await FS.readFile path, "utf8"
        handlers.parse text
      catch
        {}
  else throw new "Unknown file extension for #{ path }" 

write = ( path, data ) ->
  if ( handlers = formats[ Path.extname path ] )?
    unless Value.equal cache[ path ], data
      cache[ path ] = data
      await FS.mkdir ( Path.dirname path ), recursive: true
      FS.writeFile path, handlers.format data

Zephyr =

  Formats: formats
    
  register: register

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

