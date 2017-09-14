const { environment } = require('@rails/webpacker')

environment.loaders.get('vue').options.extractCSS = false

module.exports = environment
