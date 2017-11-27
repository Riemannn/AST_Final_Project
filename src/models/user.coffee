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

db = require '../db.coffee'

module.exports =
  all: (callback) ->
    users = {}
    # Connect to db and open read stream
    rs = db.createReadStream
      gte: 'user:!'
      lte: 'user:~'
    # Handle events
    rs.on 'data', (data) ->
      [ _, username ] = data.key.split ':'
      [ fullname, password, email ] = data.value.split ':'
      users["#{username}"] =
        fullname: fullname,
        password: password,
        email: email
    rs.on 'error', callback
    rs.on 'close', () ->
      callback null, users

  save: (users, callback) ->
    # Connect to db and open write stream
    ws = db.createWriteStream()
    # Handle errors & close
    ws.on 'error', callback
    ws.on 'close', callback

    for index, user of users
      # Get params
      username = index
      { fullname, password, email } = user
      # Save user in db
      data =
        key: "user:#{username}"
        value: "#{fullname}:#{password}:#{email}"
      ws.write data

    # Close stream
    ws.end()

  get: (username, callback) ->
    user = {}
    # Connect to db and open read stream
    rs = db.createReadStream
      gte: "user:#{username}"
      limit: 1
    # Handle events
    rs.on 'data', (data) ->
      [ fullname, password, email ] = data.value.split ':'
      user =
        "#{username}":
          fullname: fullname,
          password: password,
          email: email
    rs.on 'error', callback
    rs.on 'close', () ->
      callback null, user
