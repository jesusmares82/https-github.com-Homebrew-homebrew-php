require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc13/drupal.phar"
  sha256 "ddf33bea5f02c51b568e565aefb12d0e7366c229fa128af03989dc8b93d33eba"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "34612d3375e5f8f58dfcfd6bbbde12615ff15271b632ec5de8b52e20ae9c8bde" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
