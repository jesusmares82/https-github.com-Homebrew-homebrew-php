require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.3/codecept.phar"
  sha256 "eca8f4085072986e5c73351ca739c54fb289b11acb7ca6319b2e3e9a8eee945d"

  bottle do
    cellar :any_skip_relocation
    sha256 "5736c1d380342725665c4ac11b5f2280ed9d9f7c57092c30b66841311fdc23c8" => :el_capitan
    sha256 "9d3217f90ee59a45a3e991105b758f6889510e822ae57d089c246e50d6fe34c9" => :yosemite
    sha256 "6d378508f78363e1aef324bab00224e90f428c6045fe397810f6823ec2fa2b82" => :mavericks
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
