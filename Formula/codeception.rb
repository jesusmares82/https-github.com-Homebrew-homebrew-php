require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.8/codecept.phar"
  sha256 "85c610057131fe5a473ff7b79fc671ff7e2f09b9afb0c4a4318e48567ed48d2a"

  bottle do
    cellar :any_skip_relocation
    sha256 "0ffea1bd78e56cfa124be681e64110afca2c29610692baaffab84cfa79e8f6ad" => :sierra
    sha256 "0ffea1bd78e56cfa124be681e64110afca2c29610692baaffab84cfa79e8f6ad" => :el_capitan
    sha256 "0ffea1bd78e56cfa124be681e64110afca2c29610692baaffab84cfa79e8f6ad" => :yosemite
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
