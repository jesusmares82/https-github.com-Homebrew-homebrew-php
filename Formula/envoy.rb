require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Envoy < AbstractPhpPhar
  init
  desc "Elegant SSH tasks for PHP"
  homepage "https://github.com/laravel/envoy"
  url "https://github.com/laravel/envoy/raw/v1.0.11/envoy.phar"
  version "1.0.11"
  sha256 "e24746bd5f35d60ff1d3af1bbdb676a9a1fb64706bc7f60fa4c07e048ca169c1"

  bottle do
    cellar :any_skip_relocation
    sha256 "030419f798ad575386c580ebf07d46a9cc7773f454a4a832285953bcb76b48a2" => :el_capitan
    sha256 "418181f9aa9a77e9bbe1c0dd67ea05fd2b5b4f9ca37e75ab39de39944212f6e3" => :yosemite
    sha256 "166165e4249cd06923433ed4018c31072073b359c4026de6ba3b90c04b667982" => :mavericks
  end

  test do
    system "envoy", "--version"
  end
end
