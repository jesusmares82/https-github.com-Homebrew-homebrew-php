require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.phar"
  sha256 "40e83ec5815d584545a0514209220229d10899328351a9c513719b6af0989461"

  bottle do
    cellar :any_skip_relocation
    sha256 "5981ce99be4dc12e9b04db99b9096a7316e41902aae00e7c0113729e1c4489ac" => :sierra
    sha256 "5981ce99be4dc12e9b04db99b9096a7316e41902aae00e7c0113729e1c4489ac" => :el_capitan
    sha256 "5981ce99be4dc12e9b04db99b9096a7316e41902aae00e7c0113729e1c4489ac" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
