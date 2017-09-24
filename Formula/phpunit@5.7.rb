require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.22.phar"
  sha256 "908fa85bbf085c0fce85af36da40cbaa075997c81f085704716e0a68b88c38c7"

  bottle do
    cellar :any_skip_relocation
    sha256 "2c65aaf13c0c59b2a49a38cd9fca62843592b0eb107777873e003e3d9662b93a" => :sierra
    sha256 "2c65aaf13c0c59b2a49a38cd9fca62843592b0eb107777873e003e3d9662b93a" => :el_capitan
    sha256 "2c65aaf13c0c59b2a49a38cd9fca62843592b0eb107777873e003e3d9662b93a" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
