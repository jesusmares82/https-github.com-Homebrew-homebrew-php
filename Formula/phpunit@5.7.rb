require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.26.phar"
  sha256 "5483b06864e375ffaff506888a2ff6480561345f5a2b8d88b6d5896b89a249af"

  bottle do
    cellar :any_skip_relocation
    sha256 "d116777bb56efbc47f789db6b265ba05959473215bfd48b1bf8f3e0d6345205d" => :high_sierra
    sha256 "d116777bb56efbc47f789db6b265ba05959473215bfd48b1bf8f3e0d6345205d" => :sierra
    sha256 "d116777bb56efbc47f789db6b265ba05959473215bfd48b1bf8f3e0d6345205d" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
