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

userModel = require '../../models/user.coffee'

module.exports =
  login: (req, res) ->
    res.render 'login',
      retry: req.query.retry or false

  authenticate: (req, res) ->
    { email, password } = req.body
    userModel.getByEmail email, (err, data) ->
      throw next err if err

      if Object.keys(data).length is 0 or (password isnt data.password)
        res.redirect '/login?retry=true'
      else
        req.session.loggedIn = true
        req.session.user = data
        res.redirect '/'

  register: (req, res) ->
    user =
      email: req.body.email
      password: req.body.password
      fullname: req.body.firstname + ' ' + req.body.lastname
    userModel.save user, (err) ->
      throw next err if err

      userModel.getByEmail user.email, (err, data) ->
        req.session.loggedIn = true
        req.session.user = data
        res.redirect '/'

  logout: (req, res) ->
    delete req.session.loggedIn
    delete req.session.user
    res.redirect '/login'
