require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.5.phar"
  sha256 "f139494df066ab892e71799c157e4a41abf81cd28f16187c81faaea4a86b5321"

  bottle do
    cellar :any_skip_relocation
    sha256 "de6983460a411f73db2d615b8d91aa0ff050826e9636e2f77bcf1a6a3fd808f4" => :sierra
    sha256 "de6983460a411f73db2d615b8d91aa0ff050826e9636e2f77bcf1a6a3fd808f4" => :el_capitan
    sha256 "de6983460a411f73db2d615b8d91aa0ff050826e9636e2f77bcf1a6a3fd808f4" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
