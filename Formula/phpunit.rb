require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.4.1.phar"
  sha256 "431c65be707e32f93ba3cbccc3a2c8a9655732c750cdd9dc5b0f09bb7cc3ebf7"

  bottle do
    cellar :any_skip_relocation
    sha256 "1426df791be6372fca6f2f236d8d4d5b9ec26defe761f8c98c5ed96efe1fa611" => :high_sierra
    sha256 "1426df791be6372fca6f2f236d8d4d5b9ec26defe761f8c98c5ed96efe1fa611" => :sierra
    sha256 "1426df791be6372fca6f2f236d8d4d5b9ec26defe761f8c98c5ed96efe1fa611" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
