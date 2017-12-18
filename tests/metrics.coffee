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

should = require 'should'

userModel = require '../src/models/user'
model = require '../src/models/metrics'

describe 'Metrics', () ->
  it 'Save new user', (done) ->
    user =
      email: 'alexandre.pielucha@edu.ece.fr'
      password: 'toto'
      fullname: 'Alexandre Pielucha'

    userModel.save user, (err) ->
      should.not.exist err
      done()

  it 'Save new metrics for user', (done) ->
    metric =
      value: 50

    model.save 1, metric, (err, data) ->
      should.not.exist err
      done()
