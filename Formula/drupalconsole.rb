require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.1/drupal.phar"
  sha256 "d27c8c7283a237c2f610c5ec00b19a228fddaa02ae4dbf815d43490a0ce9e30e"

  bottle do
    cellar :any_skip_relocation
    rebuild 5
    sha256 "8c12377ebdfae6fbac8b9e61dc35117f59cc388a8b7a74a662b45b404b3dda2f" => :sierra
    sha256 "8c12377ebdfae6fbac8b9e61dc35117f59cc388a8b7a74a662b45b404b3dda2f" => :el_capitan
    sha256 "8c12377ebdfae6fbac8b9e61dc35117f59cc388a8b7a74a662b45b404b3dda2f" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
