require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.7/codecept.phar"
  sha256 "4e0a61b6e957d970b9d537cfd79a95ca624116f2083ba6cd25318e6ce81868d1"

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
    system "#{bin}/codecept", "--version"
  end
end
