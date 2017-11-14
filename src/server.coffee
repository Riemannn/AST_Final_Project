# Copyright (C) 2017 Alexandre Pielucha & Marie Perin
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

env = require '../.env.coffee'

bodyparser = require 'body-parser'
express = require 'express'
routes = require './http/routes'
stylus = require 'stylus'

module.exports =
  app: undefined

  # Instanciate an express server
  create: (host, port) ->
    this.app = express()

    this.app.set 'host', host || env.SERVER.HOST
    this.app.set 'port', port || env.SERVER.PORT || 8080

    this.app.set 'view engine', 'pug'
    this.app.set 'views', "#{ env.DIR.ROOT }/#{ env.DIR.VIEWS }"

    this.app.use bodyparser.json()
    this.app.use bodyparser.urlencoded()

    this.app.use stylus.middleware
        src: "#{ env.DIR.ROOT }/#{ env.DIR.ASSETS }/styl/",
        dest: "#{ env.DIR.ROOT }/#{ env.DIR.STATIC }/css/",
        compile: (str, path) ->
          stylus str
          .set 'filename', path
          .set 'compress', true

    this.app.use '/', express.static "#{ env.DIR.ROOT }/#{ env.DIR.STATIC }"

    routes.web this.app
    routes.api this.app

  # Run the server
  run: (callback) ->
    if !this.app.get('host')? || this.app.get('host')==''
      this.app.listen this.app.get('port'), callback("Server listening on 127.0.0.1:#{this.app.get 'port'}")
    else
      this.app.listen this.app.get('port'), this.app.get('host'), 511, callback("Server listening on #{this.app.get 'host'}:#{this.app.get 'port'}")
