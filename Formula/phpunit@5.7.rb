require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.20.phar"
  sha256 "012f7fd85ca7b34198fedd4387df453a979bc6240b90da60ad7f3ba41a0d438c"

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
