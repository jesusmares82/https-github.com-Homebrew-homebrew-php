require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.5/codecept.phar"
  sha256 "cb93a37b4c0db709971af18c5358e36deafe490c69edf14e86d0178335540d1d"

  bottle do
    cellar :any_skip_relocation
    sha256 "b7a59cdc8ede37702ae34e617d34a2733aae04b12b9a35c89040962eaa7aed1f" => :el_capitan
    sha256 "b11a87bd458cb34532ba14be9af8b86774ffd0e4f121f99885aca425f8f93b45" => :yosemite
    sha256 "f195ed3121a6744fc0900cc9d450cb17a41cb24f9d6a9cde17bcf37ee84c80f7" => :mavericks
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
