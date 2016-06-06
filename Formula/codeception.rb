require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.10/codecept.phar"
  sha256 "edfd664b3447c87e11cfef61a067f94f3dc44b14b9a448f590bf4f5fbc54a850"

  bottle do
    cellar :any_skip_relocation
    sha256 "c565aece8b663c253d514928d18894ec3643164f31dd3c4e40d09993de1e5a04" => :el_capitan
    sha256 "c2f0a5e052689f576f37b2e7052ad2742889a5637a1bf5f8e0b953d59d172277" => :yosemite
    sha256 "85bfc0fedf72cc99725b7d264addd75404e39efcc3c8e24f0622ee7a96c43a8f" => :mavericks
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
