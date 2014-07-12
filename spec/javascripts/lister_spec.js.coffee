describe 'Lister module', ->
  beforeEach ->
    @modules = [
      jasmine.createSpyObj('module_factory_0', ['init']),
      jasmine.createSpyObj('module_factory_1', ['init'])
    ]
    Lister.define 'TestModule', =>
      return @modules[0]
    @module = Lister.TestModule


  it 'should be defined', ->
    expect(Lister).toBeDefined()
  
  it 'should contain TestModule', ->
    expect(@modules[0]).toBeDefined()
    expect(Lister.TestModule).toBeDefined()    

  describe 'Lister.define', ->
    it 'should have one module defined', ->
      expect(Lister._modules.length).toEqual 1

    it 'should not create new module when defined with a repeated name', ->
      Lister.define 'TestModule', ->
        return { init: -> }
      expect(Lister._modules.length).toEqual 1
      expect(Lister.TestModule).toEqual @module

    it 'should not call the init method after redefining a module when initialized is false', ->
      Lister._initialized = false
      Lister.define 'TestModule', ->
        return @modules[1]
      expect(@modules[1].init).not.toHaveBeenCalled()

    describe 'adding a new module', ->
      it 'should not call the init method after defining a module', ->
        Lister.define 'TestModule2', =>
          return @modules[1]
        expect(@modules[1].init).not.toHaveBeenCalled()

      it 'should call the init method after defining a module when the _initialized is true', ->
        Lister._initialized = true
        Lister.define 'TestModule2', =>
          return @modules[1]
        expect(@modules[1].init).toHaveBeenCalled()

  describe 'Lister._init', ->
    it 'should call the init method for all modules defined', ->
      Lister.define 'TestModule2', =>
        return @modules[1]
      Lister._init()
      for module in @modules
        expect(module.init).toHaveBeenCalled()

    it 'should be called on the page:load event', ->
      $(document).trigger('page:load')
      expect(@modules[0].init).toHaveBeenCalled();