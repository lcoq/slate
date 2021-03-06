require 'rack'
require 'rack/contrib/try_static'

use Rack::Auth::Basic, "Restricted Access" do |user, password|
  [ user, password ] == [ ENV['AUTH_NAME'], ENV['AUTH_PASSWORD'] ]
end

use Rack::TryStatic,
    root: 'build',
    urls: %w[/],
    try: ['.html', 'index.html', '/index.html']

run lambda { |env|
  page404 = File.expand_path("../build/404/index.html", __FILE__)
  [ 404, { 'Content-Type'  => 'text/html'}, [ File.read(page404) ]]
}
