require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.7/codecept.phar"
  sha256 "4e0a61b6e957d970b9d537cfd79a95ca624116f2083ba6cd25318e6ce81868d1"

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
