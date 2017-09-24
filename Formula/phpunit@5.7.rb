require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.22.phar"
  sha256 "908fa85bbf085c0fce85af36da40cbaa075997c81f085704716e0a68b88c38c7"

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
