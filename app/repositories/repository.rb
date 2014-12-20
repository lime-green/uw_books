class Repository

  def self.find(hash)
    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    this.find_by(hash)
  end

  def self.exists?(hash)
    this.exists?(hash)
  end

  def self.new_record(hash)
    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    this.create(hash) unless exists?(hash)
  end

  protected
  def self.param_require(hash)
    required.all? { |token| hash.key? token }
  end
end
