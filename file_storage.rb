require 'json'

class Storage
  def initialize(file)
    @file = file
  end

  def save(data)
    maped_data = data.map(&:to_h)
    File.write(@file, JSON.generate(maped_data))
  end

  def load()
    if File.exist?(@file)
      r_data = File.read(@file)
      JSON.parse(r_data)
    else
      []
    end
  end
end
