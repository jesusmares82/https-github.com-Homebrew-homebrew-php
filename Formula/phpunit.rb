require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.4.phar"
  sha256 "b40bf9875537dbdefba58397ba8646825e8c97c14ef88501072f4e076162447a"

  bottle do
    cellar :any_skip_relocation
    sha256 "4d998f7d667658cad6044e411c35c7e014fd882029a9632b4c9073ca536664fa" => :sierra
    sha256 "6cd25c4abc05722722b8f664df759062bf1a24439863fc72fa955423c4232ca3" => :el_capitan
    sha256 "6cd25c4abc05722722b8f664df759062bf1a24439863fc72fa955423c4232ca3" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
