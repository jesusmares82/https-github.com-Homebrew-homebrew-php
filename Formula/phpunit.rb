require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.1.4.phar"
  sha256 "471154b49846171a0c40f6cbb4a70e03c71f6ab19a61470de63f29639799f970"

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
