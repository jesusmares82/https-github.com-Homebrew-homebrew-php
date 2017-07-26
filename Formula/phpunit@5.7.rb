require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.21.phar"
  sha256 "ea349e6c2643b4b092f2da0d12d7d234c6bb2cdf7dd7903c3882223d0c362b4e"

  bottle do
    cellar :any_skip_relocation
    sha256 "164bb4863caa6ff12d359efc1596c693609e7331ab636920b1d68098a59d9872" => :sierra
    sha256 "5cfb11d90059e5c1a4ac154dcdfaf8157686adb8a98c634e5d7f4ba0347f7d4b" => :el_capitan
    sha256 "5cfb11d90059e5c1a4ac154dcdfaf8157686adb8a98c634e5d7f4ba0347f7d4b" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
