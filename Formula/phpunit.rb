require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.4.phar"
  sha256 "a09e696f232a7008c21e02f38b437136d99d80b179666721e42fd53e8b86de27"

  bottle do
    cellar :any_skip_relocation
    sha256 "d12f4cc534010ae77e14afb8ab3f0c6ed2f2e6b80c778da10cba30764891af0f" => :high_sierra
    sha256 "d12f4cc534010ae77e14afb8ab3f0c6ed2f2e6b80c778da10cba30764891af0f" => :sierra
    sha256 "d12f4cc534010ae77e14afb8ab3f0c6ed2f2e6b80c778da10cba30764891af0f" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
