require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.4/codecept.phar"
  sha256 "684062d324cf3790f714f85be8ca9c2bcc0fede05057f6d9a50028442afaafc7"

  bottle do
    cellar :any_skip_relocation
    sha256 "5878ac0326aa36c9106dde65bcfd96d6314eb300cf74fb951127b4cc28632ca7" => :el_capitan
    sha256 "403dbcb81cd3083d1bb945187559a4fbda886533c4c55634c6ed8e6ed47c3b4e" => :yosemite
    sha256 "17c09dff2a13024b7f4ad3a68b56ff3098ff33c1ec82eda626f98c646e3f5e7f" => :mavericks
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
