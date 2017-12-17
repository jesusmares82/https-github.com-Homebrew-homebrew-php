require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.5.phar"
  sha256 "7b871b0726d40dc4d783c08f4051b400615b0d85f0a5e26c86b9a75be47c8da1"

  bottle do
    cellar :any_skip_relocation
    sha256 "b2e8438ce37c5494cd09067f01624aa2d1528876fdb59243fa0ae5838b26be02" => :high_sierra
    sha256 "b2e8438ce37c5494cd09067f01624aa2d1528876fdb59243fa0ae5838b26be02" => :sierra
    sha256 "b2e8438ce37c5494cd09067f01624aa2d1528876fdb59243fa0ae5838b26be02" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
