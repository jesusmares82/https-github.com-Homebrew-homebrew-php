require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.15.phar"
  sha256 "f0aa1ab66b511bf40591f5969d34b54ad3a9da49f84cabaef4a7a12c7c21de58"

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
