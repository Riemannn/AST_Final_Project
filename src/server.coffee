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
fs = require 'fs'
http = require 'http'
https = require 'https'
middlewares = require './http/middlewares'
morgan = require 'morgan'
routes = require './http/routes'
session = require 'express-session'
LevelStore = require('level-session-store')(session)
stylus = require 'stylus'

module.exports =
  app: undefined

  # Instanciate an express server
  create: (host, http_port, https_port) ->
    this.app = express()

    # Set server's host & port
    this.app.set 'host', host || env.SERVER.HOST
    this.app.set 'http_port', http_port || env.SERVER.HTTP_PORT || 8080
    this.app.set 'https_port', https_port || env.SERVER.HTTPS_PORT || 8443

    # Set views / templates settings
    this.app.set 'view engine', 'pug'
    this.app.set 'views', "#{ env.DIR.VIEWS }"

    # Define middlewares
    this.app.use morgan 'dev'
    this.app.use middlewares.https
    this.app.use bodyparser.json()
    this.app.use bodyparser.urlencoded({ extended: true })

    this.app.use session
      secret: 'Alex&Marie'
      store: new LevelStore env.DIR.DB + 'sessions/'
      resave: true
      saveUninitialized: true

    this.app.use stylus.middleware
      src: "#{ env.DIR.ASSETS }styl/",
      dest: "#{ env.DIR.STATIC }css/",
      compile: (str, path) ->
        stylus str
        .set 'filename', path
        .set 'compress', true

    this.app.use '/', express.static env.DIR.STATIC

    routes.auth this.app
    routes.web this.app
    routes.api this.app

  # Run the server
  run: (callback) ->
    credentials =
      key: fs.readFileSync env.DIR.SSL + 'server.key'
      cert: fs.readFileSync env.DIR.SSL + 'server.crt'

    if !this.app.get('host')? || this.app.get('host')==''
      https.createServer(credentials, this.app).listen this.app.get('https_port'), callback("Server listening HTTPS on 127.0.0.1:#{this.app.get 'https_port'}")
      http.createServer(this.app).listen this.app.get('http_port'), callback("Server listening HTTP on 127.0.0.1:#{this.app.get 'http_port'}")
    else
      https.createServer(credentials, this.app).listen this.app.get('https_port'), this.app.get('host'), 511, callback("Server listening HTTPS on #{this.app.get 'host'}:#{this.app.get 'https_port'}")
      http.createServer(this.app).listen this.app.get('http_port'), this.app.get('host'), 511, callback("Server listening HTTP on #{this.app.get 'host'}:#{this.app.get 'http_port'}")

    # if !this.app.get('host')? || this.app.get('host')==''
    #   this.app.listen this.app.get('port'), callback("Server listening on 127.0.0.1:#{this.app.get 'port'}")
    # else
    #   this.app.listen this.app.get('port'), this.app.get('host'), 511, callback("Server listening on #{this.app.get 'host'}:#{this.app.get 'port'}")
