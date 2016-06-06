require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.10/codecept.phar"
  sha256 "edfd664b3447c87e11cfef61a067f94f3dc44b14b9a448f590bf4f5fbc54a850"

  bottle do
    cellar :any_skip_relocation
    sha256 "20762f7905b425ffef66d0dee8d68dad27947321ab42d5f9cf6dc555c3307591" => :el_capitan
    sha256 "810f0459fda3769b75aafe840d7611e07f077e57def608d73716c14f032e6f67" => :yosemite
    sha256 "c3cecf5236ae8d02c6fb63bdce662337536843136bdeaaf3b76051d706af8e30" => :mavericks
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
