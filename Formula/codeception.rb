require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.6/codecept.phar"
  sha256 "9e31417fba27d9365d04d2dd8eb44468b60024c131279f62ea0b4f7828ca303c"

  bottle do
    cellar :any_skip_relocation
    sha256 "d48b8528ea4ae09d7cc99b53c714fe3e8889a2c6e9333ee2bb9205a1351e3ae3" => :sierra
    sha256 "d48b8528ea4ae09d7cc99b53c714fe3e8889a2c6e9333ee2bb9205a1351e3ae3" => :el_capitan
    sha256 "d48b8528ea4ae09d7cc99b53c714fe3e8889a2c6e9333ee2bb9205a1351e3ae3" => :yosemite
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
