require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.11.phar"
  sha256 "21cc929e9e9c2646d6975d4b143cc581c69cc955e0fdb59ca401521a247ffe2d"

  bottle do
    cellar :any_skip_relocation
    sha256 "edeba6e663fbb49d8d3d8630fd1f4c6c8aa912bf94bfc29e0e978d48583f7835" => :sierra
    sha256 "edeba6e663fbb49d8d3d8630fd1f4c6c8aa912bf94bfc29e0e978d48583f7835" => :el_capitan
    sha256 "edeba6e663fbb49d8d3d8630fd1f4c6c8aa912bf94bfc29e0e978d48583f7835" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
