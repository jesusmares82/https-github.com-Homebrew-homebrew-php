require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.2/codecept.phar"
  sha256 "8a8fe5c4ba2582bcce3c4435f7d3e92eb08f51094f12a97017646d9c8ea3cdf4"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "ebe97f91b11423e8cb7267449b08807a9fa435a5c4cf1cf7146b3c2e9d83edfa" => :el_capitan
    sha256 "e63b6fef18434fdbcc06d1b82cedce967ccb906f7fdde9634a7e3143d176c43a" => :yosemite
    sha256 "7de37c178928d376e1ae7e0f575a125da94ac6c9820727e81b562e0f30f56bd9" => :mavericks
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
