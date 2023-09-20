import FS from "node:fs/promises"
import Path from "node:path"
import * as Fn from "@dashkite/joy/function"
import * as Value from "@dashkite/joy/value"
import YAML from "js-yaml"

Formats =
  ".json":
    parse: ( text ) -> JSON.parse text
    format: ( data ) -> JSON.stringify text, null, 2
  ".yaml": _yaml =
    parse: ( text ) -> YAML.load text
    format: ( data ) -> YAML.dump data
  ".yml": _yaml

Text =
  parse: Fn.identity
  format: Fn.identity

register = ( extension, handlers ) ->
  Formats[ extension ] = handlers

cache = {}

read = ( path ) ->
  Value.clone cache[ path ] ?= await do ->
    { parse, initialize } = Formats[ Path.extname path ] ? Text
    try
      text = await FS.readFile path, "utf8"
      parse text
    catch
      undefined

write = ( path, data ) ->
  unless Value.equal cache[ path ], data
    cache[ path ] = data
    { format } = Formats[ Path.extname path ] ? Text
    await FS.mkdir ( Path.dirname path ), recursive: true
    FS.writeFile path, format data

class Zephyr

  @make: ( path ) -> Object.assign ( new @ ), { path }

  @Formats: Formats
    
  @register: register

  @exists: ( path ) -> exists path

  @read: ( path ) -> read path

  @write: ( path, data ) -> write path, data

  @update: ( path, updater ) ->
    write path, await updater await read path

  exists: -> exists @path

  read: -> read @path

  write: ( data ) -> write @path, data

  update: ( updater ) ->
    write @path, await updater await read @path

export { Zephyr }
export default Zephyr

