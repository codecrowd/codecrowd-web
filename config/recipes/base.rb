def template(source, destination)
  p "Rendering #{source} -> #{destination}"
  erb = File.read(File.expand_path(File.dirname(__FILE__)) + "/templates/#{source}")
  put ERB.new(erb).result(binding), destination
end
