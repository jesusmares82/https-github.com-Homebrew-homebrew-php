require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.2.phar"
  sha256 "989137a019a5cbdf7aac0d80df4942d5308de91c46eab7c18ed01fc78465d027"

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
