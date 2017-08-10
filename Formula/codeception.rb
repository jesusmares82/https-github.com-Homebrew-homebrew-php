require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.5/codecept.phar"
  sha256 "a04b760ee731c78b8f389815eef7f3f0a7802af704e3e7eefffc61eefce6ef13"

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
