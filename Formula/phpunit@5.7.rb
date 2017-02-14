require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.13.phar"
  sha256 "97082bd398e34c5886550f01059a9b522286d905dd5b00c26e680560fac04632"

  bottle do
    cellar :any_skip_relocation
    sha256 "08308ea747600cc9d15d95aedfa3f1d694613f277b6a26a9280110dd1ee29b08" => :sierra
    sha256 "08308ea747600cc9d15d95aedfa3f1d694613f277b6a26a9280110dd1ee29b08" => :el_capitan
    sha256 "08308ea747600cc9d15d95aedfa3f1d694613f277b6a26a9280110dd1ee29b08" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
