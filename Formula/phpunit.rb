require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.1.2.phar"
  sha256 "af6dc6fe009239030549e030e3bef6aae8e66a337ed57437e4a577424154a6ea"

  bottle do
    cellar :any_skip_relocation
    sha256 "0a9997401c91a6eb6e34e9e64edcb3956bc6af1eeb4c07754265bc4d67e2a5bd" => :sierra
    sha256 "51ba6b23f1b378a78fd8e9cb9110dace21d3f137404cd85583bb06b073971119" => :el_capitan
    sha256 "51ba6b23f1b378a78fd8e9cb9110dace21d3f137404cd85583bb06b073971119" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
