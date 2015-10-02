require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.3/codecept.phar"
  sha256 "1d18bc051c96b70b0ee113c85809ae3531e13b4355492422217b7e9ab5daa7ac"

  bottle do
    cellar :any_skip_relocation
    sha256 "250114b891f25cbd91273eeff59490e034caf541b23560cc2c3d2f9519460dab" => :el_capitan
    sha256 "48b11873f431aaaef194408c0c109dbd945e55fba26b3e9d353d755cad4fa4d1" => :yosemite
    sha256 "9c93155127d8c5604f36b264687fd992514c4b555f27c6b4ca7cc9c2e80c36dd" => :mavericks
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  def caveats; <<-EOS.undent
    To update your tests for 2.1.x check the "Upgrading" section:
    http://codeception.com/06-30-2015/codeception-2.1-is-here.html

    EOS
  end

  test do
    system "codecept", "--version"
  end
end
