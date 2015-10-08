require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Puli < AbstractPhpPhar
  init
  desc "Puli is a universal package system for PHP"
  homepage "http://puli.io"
  url "https://github.com/puli/cli/releases/download/1.0.0-beta9/puli.phar"
  version "1.0.0-beta9"
  sha256 "6092944496f4cce2c0523ee58e8ad645394f8da15e2476f9c0eaa8c1f8264ef1"

  test do
    system "puli", "--version"
  end
end
