require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.3.phar"
  sha256 "312a4b3be46029e5b182417edcc834adcea391fe52fdf5b7818dc3bb51ca4a0d"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf4f7f9984b2b62e6a72a83902a2a21d1db9b7b208badd63a8527021cc89240e" => :sierra
    sha256 "a5d512f4fdd118d3d3e79a107b46e31af8b5674dffecbc15ae32e761564d3a32" => :el_capitan
    sha256 "a5d512f4fdd118d3d3e79a107b46e31af8b5674dffecbc15ae32e761564d3a32" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
