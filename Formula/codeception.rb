require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.6/codecept.phar"
  sha256 "66277484b958d56c98a2d3ba5a085c4043260e64c45fc3caddde36db24d183ce"

  bottle do
    cellar :any_skip_relocation
    sha256 "a65c1ca451b4c0e93f691533f1007e9e9c4211072e9ff4f76d8932f8e3bd3f86" => :el_capitan
    sha256 "dba591cd6c11218f82655a43784fa5b3f49ea6fe70668d539f4c95a4d2e87324" => :yosemite
    sha256 "a7d8360e6080a3a0d2a7b3ff0f321561caf20226595ab4ee86389694f8f504dc" => :mavericks
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
