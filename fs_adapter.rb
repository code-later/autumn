class FSAdapter
  
  def write(writable)
    puts "writing data ..."
    puts "writing #{writable.file.read} ..."
  end
  
end