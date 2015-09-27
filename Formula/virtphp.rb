require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Virtphp < AbstractPhpPhar
  init
  desc "1 Box, Multiple Elephpants"
  homepage "http://virtphp.org"
  url "https://github.com/virtphp/virtphp/releases/download/v0.5.2-alpha/virtphp.phar"
  version "0.5.2-alpha"
  sha256 "776bce2f6dfd252ef9d886f14d8bbca7cb9e328e69ad900cdf14a552e7e59d30"

  test do
    system "virtphp", "--version"
  end
end
