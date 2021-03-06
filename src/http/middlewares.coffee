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

env = require '../../.env.coffee'

module.exports =
  # If no user logged in, redirect to login page
  auth: (req, res, next) ->
    unless req.session.loggedIn
      res.redirect '/login'
    else
      next()

  # Redirect HTTP requests to HTTPS
  https: (req, res, next) ->
    unless req.secure
      host = req.headers.host
      host = host.replace env.SERVER.HTTP_PORT, env.SERVER.HTTPS_PORT
      url = req.url

      res.redirect 'https://' + host + url
    else
      next()
