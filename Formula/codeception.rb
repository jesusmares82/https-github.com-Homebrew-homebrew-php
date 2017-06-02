require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.3/codecept.phar"
  sha256 "8db1f57bd09b08313a21ba40043471a9c4c536e36118c911187800687cda9efb"

  bottle do
    cellar :any_skip_relocation
    sha256 "0a8cb8382ffffa5834c8c7eaab2a844b751aadb301689ea39b5cbb432ba05042" => :sierra
    sha256 "44cffd5643370029b5e4e394a97457f66d244f395c56880d1c3cd56fc77cacfa" => :el_capitan
    sha256 "44cffd5643370029b5e4e394a97457f66d244f395c56880d1c3cd56fc77cacfa" => :yosemite
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
