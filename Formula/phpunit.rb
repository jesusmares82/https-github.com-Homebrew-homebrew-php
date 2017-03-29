require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.11.phar"
  sha256 "21cc929e9e9c2646d6975d4b143cc581c69cc955e0fdb59ca401521a247ffe2d"

  bottle do
    cellar :any_skip_relocation
    sha256 "e18cf8bbf6336124b994747a321bd9ff3bab4af3d03e01720f965f5b41f098aa" => :sierra
    sha256 "e18cf8bbf6336124b994747a321bd9ff3bab4af3d03e01720f965f5b41f098aa" => :el_capitan
    sha256 "e18cf8bbf6336124b994747a321bd9ff3bab4af3d03e01720f965f5b41f098aa" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
