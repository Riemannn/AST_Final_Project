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
  all: (userID, callback) ->
    metrics = []

    # Connect to db and open read stream
    rs = db.createReadStream
      gte: "metrics:#{userID}:!"
      lte: "metrics:#{userID}:~"

    # Handle events
    rs.on 'data', (data) ->
      [ _, _, timestamp ] = data.key.split ':'
      value = data.value
      metrics.push
        timestamp: timestamp
        value: value

    rs.on 'error', callback
    rs.on 'close', () ->
      callback null, metrics

  save: (userID, metric, callback) ->
    # Connect to db and open write stream
    ws = db.createWriteStream()
    # Handle errors & close
    ws.on 'error', callback
    ws.on 'close', callback

    # Get params
    { value } = metric

    # Save metric in db
    data =
      key: "metrics:#{userID}:#{Date.now()}"
      value: value
    ws.write data

    # Close stream
    ws.end()
