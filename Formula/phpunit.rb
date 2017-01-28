require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.9.phar"
  sha256 "67accba42c36746d6c71c437b073784002a7fc2c4a045c1928b7ee0fedcf13bd"

  bottle do
    cellar :any_skip_relocation
    sha256 "0aad2945a936c5f6537c4872537df0141ac53f7b75863ed78806de8215e19d88" => :sierra
    sha256 "b203abd233b2d0b973c499e2e63c0bc7b4d1fb1600c2dd4cf51fa0251b24765a" => :el_capitan
    sha256 "b203abd233b2d0b973c499e2e63c0bc7b4d1fb1600c2dd4cf51fa0251b24765a" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
