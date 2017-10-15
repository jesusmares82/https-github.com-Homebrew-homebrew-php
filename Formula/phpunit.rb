require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.4.2.phar"
  sha256 "bf429a37b0664d9997da31467b800e5de800ffc1f01350bec1774dc8c9dcac23"

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
