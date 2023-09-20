import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import FS from "node:fs/promises"

# MUT
import Zephyr from "../src"

do ->

  print await test "Zephyr", [

    test "YAML", ->
      await Zephyr.update "test/test.yaml", ( data ) ->
        if data?
          {}  # cause test to fail
        else
          greeting: "Hello, world!"
      data = await Zephyr.read "test/test.yaml"
      assert.equal data.greeting, "Hello, world!"
      FS.rm "test/test.yaml"

  ]

  process.exit if success then 0 else 1
