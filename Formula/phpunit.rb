require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.4.4.phar"
  sha256 "c9e5ee0779b6ec66cc6ac1f09a1cf3777b041d0b7f2b85583d7908e786077559"

  bottle do
    cellar :any_skip_relocation
    sha256 "08a551805c715551677d21a611a7cdb51e0933f053fece6ec8b17496cc2dce3b" => :high_sierra
    sha256 "2c50f1b7aea8e98d94dcde6b5982bfd9c9c584ec7bd7fba0056843ac8151b662" => :sierra
    sha256 "2c50f1b7aea8e98d94dcde6b5982bfd9c9c584ec7bd7fba0056843ac8151b662" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
