require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.25.phar"
  sha256 "029f455385405f43f55cf081daa269d296fa1a5dadb3c4e6e42611e6ec581c18"

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
