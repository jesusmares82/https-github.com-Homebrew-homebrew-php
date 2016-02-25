require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.10.12/drupal.phar"
  sha256 "ac99afd5bcdc8f7dfe7c2e4fcd36f1f0809aa505490777ec5a05c930d8c2f3d5"

  bottle do
    cellar :any_skip_relocation
    sha256 "43234b35a58c96a91dddf3dee8b9160d6011838fd8a8765a449deaab0e857af6" => :el_capitan
    sha256 "4b0c8655a8013578273a89a2754cb9b52e3d74fbb84f28f997227e04f30417ae" => :yosemite
    sha256 "b5b9b13d8d0a8c5eb20d57d2f9d75f8a8a17e75c2c5c3f6f52b0e1ca4cd20bbf" => :mavericks
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end
