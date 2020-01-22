class NumberGenerator
  @queue = :default

  def self.perform(num_amount = 4)
    my_url = "https://www.random.org/integers/?num=#{num_amount}&min=0&max=7&col=1&base=10&format=plain&rnd=new"
    # raw_response.body returns a string of length num_amount
    raw_response = HTTParty.get(my_url)
    return raw_response.gsub(/\n|\s+/, "")
  end
end
