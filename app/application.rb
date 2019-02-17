class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
      elsif req.path.match(/add/)
        search_term = req.params["item"]
         resp.write handle_search(search_term)
         # binding.pry
          @@items.each do |item|
            if item
            @@cart << item
            resp.write "added #{item}\n"
            end
          end
      else
        resp.write "Your cart is empty"
      end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "added #{search_term}\n"
    else
      return "We don't have that item"
    end
  end
end
