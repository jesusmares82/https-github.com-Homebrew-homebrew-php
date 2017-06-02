require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.2.1.phar"
  sha256 "2c158a8f97b37f356e881bfbb348018812af8371cb1119eb887c94f82bac30b0"

  bottle do
    cellar :any_skip_relocation
    sha256 "fd39566b3522398d678c2220132c7c224226b299a61f0d114024ac87d1ef3afe" => :sierra
    sha256 "4f8a36e47df80ed65f14bb975bcd282491a09c3786bc94f2efd106d962977e2f" => :el_capitan
    sha256 "4f8a36e47df80ed65f14bb975bcd282491a09c3786bc94f2efd106d962977e2f" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
