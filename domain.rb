class Domain

  def initialize(address)
    @address = address
    @valid = false
    check_domain
  end

  def valid?
    @valid
  end

  private

  def check_domain
    return unless @address.is_a?(String)
    return if domain_with_not_enough_length?
    return if domain_not_composed_of_numeric_values?
    @valid = true
  end

  def domain_with_not_enough_length?
    @address&.split(".")&.count != 4
  end

  def domain_not_composed_of_numeric_values?
    !@address.split(".").map do |domain_part|
      domain_part.match(/^(\d)+$/)&.size
    end.all?(Integer)
  end

end
