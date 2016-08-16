require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.4/codecept.phar"
  sha256 "d81aa0d8754c5ed9fb71eda9827c1712c7368b9a95877284957d587e5f219645"

  bottle do
    cellar :any_skip_relocation
    sha256 "f950c539e615a0695db23f501515e4b94000c12d6a02e20b149fff08077cf45c" => :el_capitan
    sha256 "87f2020281b2ae130bc49ffd722d829b644d6874245d2d380dce8bc5920617d3" => :yosemite
    sha256 "c29cd92f980fe2ba91fc458722910c510588a3794044c651425462b4d82c055a" => :mavericks
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "codecept", "--version"
  end
end
