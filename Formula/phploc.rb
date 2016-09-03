require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-3.0.1.phar"
  sha256 "a712dec6b1044505a411d207813c6b11cc1c138c0ed467f65788b6f9441c9701"

  bottle do
    cellar :any_skip_relocation
    sha256 "5bed4234b52f850227466925c4a5152792c2ddec3d8b6cbf5378c10799aa8ff9" => :el_capitan
    sha256 "b770b3f23a8faee174aeb95af5d9df46b43bbddf9df2668603be6af947d9419a" => :yosemite
    sha256 "b770b3f23a8faee174aeb95af5d9df46b43bbddf9df2668603be6af947d9419a" => :mavericks
  end

  def phar_file
    "phploc-#{version}.phar"
  end

  test do
    system "phploc", "--version"
  end
end
