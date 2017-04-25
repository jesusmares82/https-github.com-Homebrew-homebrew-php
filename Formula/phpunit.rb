require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.1.2.phar"
  sha256 "af6dc6fe009239030549e030e3bef6aae8e66a337ed57437e4a577424154a6ea"

  bottle do
    cellar :any_skip_relocation
    sha256 "f8a4232c74231a0f148f18c50e02bab04ac907746839d00db4a7fe4ef0d038c6" => :sierra
    sha256 "30f76c651e046fa53fc5202ef5e823cd1e02243dada6cefde0b097ce502b8dcf" => :el_capitan
    sha256 "30f76c651e046fa53fc5202ef5e823cd1e02243dada6cefde0b097ce502b8dcf" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
