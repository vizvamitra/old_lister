window.Lister = window.Lister || do ->
  modules = []
  initialized = false

  define = (name, module) ->
    window.Lister[name] = window.Lister[name] || do ->
      modules.push(name)
      newModule = module()

      if (window.Lister.initialized)
        newModule.init()

      return newModule

    return window.Lister[name]

  init = ->
    for i in [0..modules.length-1]
      window.Lister[modules[i]].init()

    window.Lister.initialized = true

  return {
    _init: init,
    define: define,
    _modules: modules,
    _initialized: initialized,
    _registered: false
  }

window.Lister._initialized = false;

$ ->
  if (!window.Lister._registered)
    $(document).ready(window.Lister._init)
    $(document).on('page:load', window.Lister._init)

    window.Lister._registered = true