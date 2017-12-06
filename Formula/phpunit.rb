require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.3.phar"
  sha256 "b6365deb4dac45855b5838623f60de0e966076ca102134b5dcb79bf3f6d80f4f"

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
