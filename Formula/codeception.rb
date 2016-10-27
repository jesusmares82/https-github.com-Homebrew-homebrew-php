require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.6/codecept.phar"
  sha256 "21ebede0380599dcf7d26a364de355e79d93f14f7acbb355c2ded094d5a57bb1"

  bottle do
    cellar :any_skip_relocation
    sha256 "eb87fc61169bc07723b33106451af4ef801f52bd2eeec46509161484fc419369" => :sierra
    sha256 "eb87fc61169bc07723b33106451af4ef801f52bd2eeec46509161484fc419369" => :el_capitan
    sha256 "eb87fc61169bc07723b33106451af4ef801f52bd2eeec46509161484fc419369" => :yosemite
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "codecept", "--version"
  end
end
