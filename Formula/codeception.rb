require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.2/codecept.phar"
  sha256 "8a8fe5c4ba2582bcce3c4435f7d3e92eb08f51094f12a97017646d9c8ea3cdf4"

  bottle do
    cellar :any
    sha256 "d92fa3ed6cd96904ae352d23a8c5026a06f41ce7c265f864f8f8963eca252e5c" => :yosemite
    sha256 "f3f481e26a2a392932812cfeeb57c507c7655d1a98f90d4b474b757ee0f94b62" => :mavericks
    sha256 "7a10d2f42850f7d7733d17806feaf0b0bc4fd212dc6556e61291cd8ea7a276e3" => :mountain_lion
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
