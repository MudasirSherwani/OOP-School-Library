require 'json'

class Storage
  def initialize(file)
    @file = file
  end

  def save(data)
    if File.exist?(@file)
      maped_data = data.map(&:to_h)
      File.write(@file, JSON.generate(maped_data))
    end
  end

  def load()
    if File.exist?(@file) && valid?
      r_data = File.read(@file)
      result = JSON.parse(r_data)
    else
      []
    end
  end

  def valid?()
    begin
    result = ''
    if File.exist?(@file)
      r_data = File.read(@file)
    result = JSON.parse(r_data)
    end
    result.is_a?(Hash) || result.is_a?(Array)
  rescue JSON::ParserError, TypeError
    false
  end
end

end
