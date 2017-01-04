require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc14/drupal.phar"
  sha256 "46918cd319bbf29c60d14e0c7864e5346f7fdbfb8d77123b3579366d43a03e45"

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
