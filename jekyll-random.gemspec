Gem::Specification.new do |s|
  s.name          = "jekyll-random"
  s.version       = "0.0.3"
  s.licenses      = ['MIT']
  s.summary       = "A Jekyll plugin that generates pseudo-random data"
  s.description   = "A Jekyll plugin that generates pseudo-random data. Very useful when you want to generate a large amount of random data."
  s.authors       = ["Paweł Kuna"]
  s.email         = 'codecalm@gmail.com'
  s.files = [
    "lib/jekyll-random.rb"
  ]
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/codecalm/jekyll-random'
  s.metadata      = { "source_code_uri" => "https://github.com/codecalm/jekyll-random" }

  s.add_dependency "jekyll", "~> 3.3"
end