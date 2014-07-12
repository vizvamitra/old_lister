Lister._clear = ->
  for i in [0..Lister._modules.length - 1]
    delete Lister[Lister._modules[i]]
  Lister._modules.length = 0

beforeEach ->
  Lister._clear()
  Lister._initialized = false

window.p = (object) -> console.log object