require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc6/drupal.phar"
  sha256 "f6ec69d78a4f72507ea01880f52e898df9af5cc10d703822759ebd1f32c34b36"

  bottle do
    cellar :any_skip_relocation
    sha256 "9c87a1efa4fe117ced8d22ea86a3199bfc89f0a1c7965c644836b4de0309ef3a" => :sierra
    sha256 "9c87a1efa4fe117ced8d22ea86a3199bfc89f0a1c7965c644836b4de0309ef3a" => :el_capitan
    sha256 "9c87a1efa4fe117ced8d22ea86a3199bfc89f0a1c7965c644836b4de0309ef3a" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end
