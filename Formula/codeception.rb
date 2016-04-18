require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.8/codecept.phar"
  sha256 "6e65b9905a6ca9b57ae99137cc4105960242b2464ec6a4e120193945d8f1bc10"

  bottle do
    cellar :any_skip_relocation
    sha256 "8071fd5d99b34d08f1058dbb3f127acdebf2fba44e39492130fab34f85dfabf9" => :el_capitan
    sha256 "225f9bf43e460f42d02a42368738057a57bff3381fe6332e0a9c9d018876beae" => :yosemite
    sha256 "42e24ed697258af75958453fcf4f41ca5532034fcf8ed218c4cfabf0b19abd66" => :mavericks
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
