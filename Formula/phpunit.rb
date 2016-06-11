require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.4.4.phar"
  sha256 "73876eda0fdda2cff1e1b88a3330406c987128b420288f5b2d23de0b4383a0f7"

  bottle do
    cellar :any_skip_relocation
    sha256 "83c69755901dd99efca6ebc2266b729492fa7ec93122b5507d64f42cacfce6e6" => :el_capitan
    sha256 "edd3e83e907721bc512045c706cf45607943fad45479aa1cf825f670f8b1c415" => :yosemite
    sha256 "7359dde710c43e389881ce9c9bebd3f989aaae23e962706cd33b3d837e2f8217" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
