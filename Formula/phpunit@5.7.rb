require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.14.phar"
  sha256 "fcbae5c5e90d599c2e1086e7fa8cb6cd5eded75209ab961fe4005762f11e19c9"

  bottle do
    cellar :any_skip_relocation
    sha256 "b6d38af73ba5d5ec6a730960fee9de570172fc69dbe5b9f4e7c78da11970f764" => :sierra
    sha256 "b6d38af73ba5d5ec6a730960fee9de570172fc69dbe5b9f4e7c78da11970f764" => :el_capitan
    sha256 "b6d38af73ba5d5ec6a730960fee9de570172fc69dbe5b9f4e7c78da11970f764" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
