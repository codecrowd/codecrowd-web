Personal::Engine.routes.draw do
  get '(*everything)' => ->(env) { [200, {}, ["Personal pages for subdomain: #{env['REQUEST_METHOD']} #{env['SERVER_NAME']}:#{env['SERVER_PORT']}#{env['PATH_INFO']}"]] }
end
