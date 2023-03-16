require 'json'

class Storage
def initialize(file)
    @file = file
end

def save(data)
    maped_data = data.map(&:to_h)
    File.write(file, JSON.generate(maped_data))
end

end