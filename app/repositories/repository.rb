class Repository

  def self.find(hash)
    model.find_by(hash)
  end

  def self.exists?(hash)
    model.exists?(hash)
  end

  def self.new_record(hash)
    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    model.find_by(hash.slice *identified_by) || model.create!(hash)
  end

  protected
  def self.param_require(hash)
    required.all? { |token| hash.key? token }
  end
end
