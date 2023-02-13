class App < Roda
  route do |r|
    r.root do 
      'hello there'
    end
  end
end