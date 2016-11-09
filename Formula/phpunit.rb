require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.6.2.phar"
  sha256 "6de0442d0c731d7aba478f6fc3879c27b00f5b4c8ef7bcd812d8f7d442f9aa37"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f428ad457e9572026216958f55dc8ccb423ebb82ed26ca2c8ec86ca6f8b2a16" => :sierra
    sha256 "7f428ad457e9572026216958f55dc8ccb423ebb82ed26ca2c8ec86ca6f8b2a16" => :el_capitan
    sha256 "7f428ad457e9572026216958f55dc8ccb423ebb82ed26ca2c8ec86ca6f8b2a16" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
