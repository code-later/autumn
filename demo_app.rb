require 'lib/autumn'

require 'image'

injector = Autumn::Injector.new('application_context.yml')
injector.inject_context!

image = Image.new
image.file = StringIO.new("demo file")
image.save