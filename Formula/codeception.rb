require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.3.1/codecept.phar"
  sha256 "d63dd4130786defea9909931cacfddabe1eb643fe1ae365d2e01c997774283c7"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce8180339c089b728fa1aad4e462a5c2598fbca1cb461d512074dcf0a379bf3a" => :sierra
    sha256 "d76f3df86c0506228b4fe10184d495b8c872195382b2ea8d70e5794a756b96e8" => :el_capitan
    sha256 "d76f3df86c0506228b4fe10184d495b8c872195382b2ea8d70e5794a756b96e8" => :yosemite
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
