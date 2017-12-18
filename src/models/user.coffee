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
    users = []

    # Connect to db and open read stream
    rs = db.createReadStream
      gte: 'users:!'
      lte: 'users:~'

    # Handle events
    rs.on 'data', (data) ->
      [ _, id ] = data.key.split ':'
      [ email, password, fullname ] = data.value.split ':'
      users.push
        id: id
        email: email
        password: password
        fullname: fullname

    rs.on 'error', callback
    rs.on 'close', () ->
      callback null, users

  save: (user, callback) ->
    db.get 'user_id', (err, data) ->
      if err
        data = 0

      id = parseInt(data) + 1

      # Connect to db and open write stream
      ws = db.createWriteStream()
      # Handle errors & close
      ws.on 'error', callback
      ws.on 'close', callback

      # Get params
      { email, password, fullname } = user

      ws.write
        key: "emails:#{email}"
        value: id
      # Save user in db
      data =
        key: "users:#{id}"
        value: "#{email}:#{password}:#{fullname}"
      ws.write data

      # Close stream
      ws.end()

      # Store last user ID
      db.put 'user_id', id

  get: (id, callback) ->
    user = {}

    # Connect to db and open read stream
    rs = db.createReadStream
      gte: "users:#{id}"
      lte: "users:#{id}"
    # Handle events
    rs.on 'data', (data) ->
      [ _, id ] = data.key.split ':'
      [ email, password, fullname ] = data.value.split ':'
      user =
        id: id
        email: email
        password: password
        fullname: fullname
    rs.on 'error', callback
    rs.on 'close', () ->
      callback null, user

  getByEmail: (email, callback) ->
    self = this

    db.get "emails:#{email}", (err, data) ->
      return callback null, {} if err

      id = data
      self.get id, callback
