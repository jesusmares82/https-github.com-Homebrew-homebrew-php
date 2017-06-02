require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.2.1.phar"
  sha256 "2c158a8f97b37f356e881bfbb348018812af8371cb1119eb887c94f82bac30b0"

  bottle do
    cellar :any_skip_relocation
    sha256 "d1d93b48c7afef0a8c7e90966b5d539635d842770b4538ccc155fce75e7b7b1b" => :sierra
    sha256 "11dbf663eadd0bb39d135fcd09afa429183d1d54f1f3e271eb416c2bdf29f639" => :el_capitan
    sha256 "11dbf663eadd0bb39d135fcd09afa429183d1d54f1f3e271eb416c2bdf29f639" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
