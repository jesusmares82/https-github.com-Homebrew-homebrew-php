require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.6.1.phar"
  sha256 "5af8532027552331036927cf2623e90bc0f9add98602553a297bcae9d70d59d4"

  bottle do
    cellar :any_skip_relocation
    sha256 "fbb70ab4e033a28b1395333586d9048abb007908e69a10048b44966d8c3b00e9" => :el_capitan
    sha256 "49c2d25b7e6dc6dbe9fd6b7fbca7e1703d76dbf6ed23f405130aea8a5a69ec4c" => :yosemite
    sha256 "49c2d25b7e6dc6dbe9fd6b7fbca7e1703d76dbf6ed23f405130aea8a5a69ec4c" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
