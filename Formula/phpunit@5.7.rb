require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.23.phar"
  sha256 "a67bb9589bafa194206c8eb8f5b7a95b4b842ae0b4a2d538018a1761a13c0fbc"

  bottle do
    cellar :any_skip_relocation
    sha256 "599f536780739519724736a19ce10e8d0fba644eb7628ac13ff465762f2b4b16" => :high_sierra
    sha256 "561456f1c1a13bb312098b13bd58c3f5bd34499d4fa5318ab9863bd792801716" => :sierra
    sha256 "561456f1c1a13bb312098b13bd58c3f5bd34499d4fa5318ab9863bd792801716" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
