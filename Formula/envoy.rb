require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Envoy < AbstractPhpPhar
  init
  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/raw/v1.0.11/envoy.phar"
  version "1.0.11"
  sha256 "e24746bd5f35d60ff1d3af1bbdb676a9a1fb64706bc7f60fa4c07e048ca169c1"

  test do
    system "envoy", "--version"
  end
end
