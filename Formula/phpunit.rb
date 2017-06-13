require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.2.2.phar"
  sha256 "62eedccb119b86570e6c867cb89671e04da4694fb4c7595ffcde3142e51fbf79"

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
