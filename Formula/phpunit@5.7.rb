require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.23.phar"
  sha256 "a67bb9589bafa194206c8eb8f5b7a95b4b842ae0b4a2d538018a1761a13c0fbc"

  bottle do
    cellar :any_skip_relocation
    sha256 "82d8c7efe6020cf766f28f5697dcf05af88f36b10a0967088988ef7fa462ac84" => :high_sierra
    sha256 "82d8c7efe6020cf766f28f5697dcf05af88f36b10a0967088988ef7fa462ac84" => :sierra
    sha256 "82d8c7efe6020cf766f28f5697dcf05af88f36b10a0967088988ef7fa462ac84" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
