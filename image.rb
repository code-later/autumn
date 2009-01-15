class Image
  
  attr_accessor :file, :adapter, :generator
  
  def save
    puts "saving image ..."
    @adapter.write(self)
    @generator.generate
  end
  
end