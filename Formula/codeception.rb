require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.3/codecept.phar"
  sha256 "8db1f57bd09b08313a21ba40043471a9c4c536e36118c911187800687cda9efb"

  bottle do
    cellar :any_skip_relocation
    sha256 "950dee534ebea25c207f3d530d95b980cdf20af14623f2ee9032d9017b5c9411" => :sierra
    sha256 "454f6baab31a53b0189e4244d63f35312fbf07ced3e62aa249bfd4be56ef69c8" => :el_capitan
    sha256 "454f6baab31a53b0189e4244d63f35312fbf07ced3e62aa249bfd4be56ef69c8" => :yosemite
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "#{bin}/codecept", "--version"
  end
end
