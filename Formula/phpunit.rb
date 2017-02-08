require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.6.phar"
  sha256 "e42242a3f10f3d1b86b048de3503c9bab73cfce7e86f3ede52a7e7d7af238369"

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
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
