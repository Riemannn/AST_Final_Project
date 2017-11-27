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

module.exports =
  # Declare here all controllers
  controllers:
    home: require './controllers/home'
    metrics: require './controllers/metrics'
    user: require './controllers/user'



  # Define all web routes
  web: (app) ->
    ctrls = this.controllers

    # Home Controller
    this.get app, '/', ctrls.home.index
    this.get app, '/login', ctrls.home.login
    this.post app, '/login', ctrls.home.connect



  # Define all api routes
  api: (app) ->
    ctrls = this.controllers

    # Metrics Controller
    this.getApi app, '/metrics', ctrls.metrics.index
    # this.postApi app, '/metrics', ctrls.metrics.store
    # User Controller
    this.getApi app, '/users', ctrls.user.index
    this.postApi app, '/users', ctrls.user.store
    this.getApi app, '/users/:username', ctrls.user.get



  # Expose a GET webpage
  get: (app, url, controllerFunc) ->
    app.get url, controllerFunc

  # Expose a POST webpage
  post: (app, url, controllerFunc) ->
    app.post url, controllerFunc

  # Expose a GET API returning a JSON response
  getApi: (app, url, controllerFunc) ->
    app.get "/api#{url}", controllerFunc

  # Expose a POST API
  postApi: (app, url, controllerFunc) ->
    app.post "/api#{url}", controllerFunc
