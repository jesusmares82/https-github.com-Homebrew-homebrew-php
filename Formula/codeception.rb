require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Codeception < AbstractPhpPhar
  init
  desc "Testing Framework designed to work just out of the box"
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.2.4/codecept.phar"
  sha256 "d81aa0d8754c5ed9fb71eda9827c1712c7368b9a95877284957d587e5f219645"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5d78c79b7164e93193d266efb89539ff3a67acf78f765c545ba57a081df9aa0" => :el_capitan
    sha256 "768d7a18441aa3515efcaa4d9400c2ed8d7812e7f05e77377fac715995b6f4e7" => :yosemite
    sha256 "3d959723b8b4448137ac59a55f2b3c802a93d63168458ea8525caa95cc83ce55" => :mavericks
  end

  def phar_file
    "codecept.phar"
  end

  def phar_bin
    "codecept"
  end

  test do
    system "codecept", "--version"
  end
end
