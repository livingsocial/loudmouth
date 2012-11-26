# To build the test file, run 'coffee -c main.coffee' or 'coffee -w -c main.coffee' to continuously watch & build

describe 'Loudmouth', ->

  describe '#complainLoudly', ->
    it 'should show complaints via an alert', ->
      alert_stub = sinon.stub(window, 'alert')
      Loudmouth.addError('error-message', 'error-url', 'error-line-number')
      Loudmouth.complainLoudly()
      assert(alert_stub.called)
      window.alert.restore()

    it 'should indicate if there was more than one exception', ->
      alert_stub = sinon.stub(window, 'alert')
      Loudmouth.addError('error-message', 'error-url', 'error-line-number')
      Loudmouth.addError('error-message', 'error-url', 'error-line-number')
      Loudmouth.complainLoudly()
      sinon.assert.calledWith(alert_stub, sinon.match(/2 JavaScript exceptions/))
      window.alert.restore()

    it 'should say there are no complaints', ->
      logger_spy = sinon.spy(Loudmouth, 'logger')
      Loudmouth.complainLoudly()
      assert(logger_spy.called)
      Loudmouth.logger.restore()

  describe '#captureAlerts', ->
    it 'should tell you that alerts are being captured'
    it 'should capture alerts'
    it 'should show the alert'
    it 'should return the Loudmouth object'

  describe '#complainSilently', ->
    hollaback_stub = null

    before ->
      hollaback_stub = sinon.stub(Loudmouth, 'hollaback')

    beforeEach ->
      hollaback_stub.reset()

    after ->
      Loudmouth.hollaback.restore()

    it 'should hollaback complaints', ->
      Loudmouth.addError('error-message', 'error-url', 'error-line-number')
      Loudmouth.complainSilently()
      assert(hollaback_stub.called)

    it 'should do nothing if there are no complaints', ->
      Loudmouth.complainSilently()
      assert(! hollaback_stub.called)

  describe '#hollaback', ->
    it 'should send error information'
      # Deferred until we get a DOM emulator in place      

    it 'should warn if there is no hollaback URL', ->
      Loudmouth.hollaback_url('')
      logger_stub = sinon.stub(Loudmouth, 'logger')
      Loudmouth.hollaback({fake: 'error'})
      assert(logger_stub.called)
      Loudmouth.logger.restore()

  describe '#watch', ->
    it 'should return Loudmouth (for chaining)', ->
      w = Loudmouth.watch()
      assert(w == Loudmouth)

    describe 'changes window.onerror so it', ->
      onerror_stub = null
      addError_stub = null
      complain_stub = null

      before ->
        addError_stub = sinon.stub(Loudmouth, 'addError')
        complain_stub = sinon.stub(Loudmouth, 'complainLoudly')
        onerror_stub = sinon.stub(window, 'onerror').returns(true)
        Loudmouth.watch()
        window.onerror('error message', 'url', 123)
      after ->
        Loudmouth.addError.restore()
        complain_stub.restore()
        onerror_stub.restore()

      it 'calls the original onError', ->
        assert(onerror_stub.called)

      it 'adds the error', ->
        assert(addError_stub.called)

      it 'complains loudly', ->
        assert(complain_stub.called)

  describe '#lurk', ->
    it 'should return Loudmouth (for chaining)', ->
      w = Loudmouth.lurk()
      assert(w == Loudmouth)

    it 'should complain if the hollaback URL isn\'t set', ->
      logger_spy = sinon.spy(Loudmouth, 'logger')
      w = Loudmouth.lurk(null, null, logger_spy)
      assert(logger_spy.called)
      Loudmouth.logger.restore()

    describe 'changes window.onerror so it', ->
      onerror_stub = null
      addError_stub = null
      complain_stub = null
      logger_stub = null

      before ->
        addError_stub = sinon.stub(Loudmouth, 'addError')
        complain_stub = sinon.stub(Loudmouth, 'complainSilently')
        logger_stub = sinon.stub(Loudmouth, 'logger')
        onerror_stub = sinon.stub(window, 'onerror').returns(true)
        Loudmouth.lurk()
        window.onerror('error message', 'url', 123)
      after ->
        Loudmouth.addError.restore()
        Loudmouth.complainSilently.restore()
        Loudmouth.logger.restore()

      it 'calls the original onError', ->
        assert(onerror_stub.called)

      it 'adds the error', ->
        assert(addError_stub.called)

      it 'complains loudly', ->
        assert(complain_stub.called)

  describe '#goAway', ->
    it 'should restore the original onError'
