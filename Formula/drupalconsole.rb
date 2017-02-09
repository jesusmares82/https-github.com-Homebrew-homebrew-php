require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc16/drupal.phar"
  sha256 "7ca1d3291b1b87efddcf1c231c09bcf803b87ed1e5d3ab79496dcde0217297c2"

  bottle do
    cellar :any_skip_relocation
    rebuild 4
    sha256 "36d18d7fcd8e9fe7472d8db2f9b0ecb801762beb6c06b7ea3853e24783c83673" => :sierra
    sha256 "36d18d7fcd8e9fe7472d8db2f9b0ecb801762beb6c06b7ea3853e24783c83673" => :el_capitan
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
