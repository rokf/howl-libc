require_bundle('c')

unload = () ->
  howl.mode.by_name('c').api = nil
  -- howl.mode.by_name('c').completers = { 'in_buffer' }

howl.mode.by_name('c').api = bundle_load('libc_api')
-- howl.mode.by_name('c').completers = { 'in_buffer', 'api' }

return {
  info:
    author: 'Rok Fajfar'
    description: 'libc API'
    license: 'MIT'
  :unload
}
