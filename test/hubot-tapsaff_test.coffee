chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hubot-strava', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/hubot-tapsaff')(@robot)

  it 'registers a respond listener for Tapsaff', ->
    expect(@robot.respond).to.have.been.calledWith(/tapsaff$/i)

  it 'registers a respond listener for Tapsaff with a location', ->
    expect(@robot.respond).to.have.been.calledWith(/tapsaff in (.+)$/i)
