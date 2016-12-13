require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.4.phar"
  sha256 "b40bf9875537dbdefba58397ba8646825e8c97c14ef88501072f4e076162447a"

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
