require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.4/codecept.phar"
  sha256 "e1885096e7199fad77b64a95aab180254b8a5f9919a774e9816aefa708da611f"

  bottle do
    cellar :any_skip_relocation
    sha256 "be133a4a3b96900947fed48ebf71fb3f34bc619db41bd83725f2eec96dce6357" => :sierra
    sha256 "be133a4a3b96900947fed48ebf71fb3f34bc619db41bd83725f2eec96dce6357" => :el_capitan
    sha256 "be133a4a3b96900947fed48ebf71fb3f34bc619db41bd83725f2eec96dce6357" => :yosemite
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
