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

model = require '../src/models/user'

describe 'User', () ->
  it 'Get user by ID when none created', (done) ->
    model.get 1, (err, data) ->
      should.not.exist err

      should.not.exist data.id
      should.not.exist data.email
      should.not.exist data.password
      should.not.exist data.fullname

      done()
  it 'Get user by email when none created', (done) ->
    model.getByEmail 'alexandre.pielucha@edu.ece.fr', (err, data) ->
      should.not.exist err

      should.not.exist data.id
      should.not.exist data.email
      should.not.exist data.password
      should.not.exist data.fullname

      done()

  it 'Save new user', (done) ->
    user =
      email: 'alexandre.pielucha@edu.ece.fr'
      password: 'toto'
      fullname: 'Alexandre Pielucha'

    model.save user, (err) ->
      should.not.exist err
      done()

  it 'Get user by ID when created', (done) ->
    model.get 1, (err, data) ->
      should.not.exist err
      data.should.have.property('id', '1')
      data.should.have.property('email', 'alexandre.pielucha@edu.ece.fr')
      data.should.have.property('password', 'toto')
      data.should.have.property('fullname', 'Alexandre Pielucha')
      done()

  it 'Get user by email when created', (done) ->
    model.getByEmail 'alexandre.pielucha@edu.ece.fr' , (err, data) ->
      should.not.exist err
      data.should.have.property('id', '1')
      data.should.have.property('email', 'alexandre.pielucha@edu.ece.fr')
      data.should.have.property('password', 'toto')
      data.should.have.property('fullname', 'Alexandre Pielucha')
      done()
