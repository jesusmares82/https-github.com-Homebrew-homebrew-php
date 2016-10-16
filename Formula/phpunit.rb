require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.6.1.phar"
  sha256 "5af8532027552331036927cf2623e90bc0f9add98602553a297bcae9d70d59d4"

  bottle do
    cellar :any_skip_relocation
    sha256 "e76fb5197ba89bed1cce49e0401dca77782e3c6635de412c8bc1a0678f63b9cd" => :sierra
    sha256 "e76fb5197ba89bed1cce49e0401dca77782e3c6635de412c8bc1a0678f63b9cd" => :el_capitan
    sha256 "e76fb5197ba89bed1cce49e0401dca77782e3c6635de412c8bc1a0678f63b9cd" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
