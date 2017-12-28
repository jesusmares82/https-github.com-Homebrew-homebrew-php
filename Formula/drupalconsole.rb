require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.3.1/drupal.phar"
  sha256 "88d79bcbfd2627e9840894111c6bc980ebb12b87950600266ae429d7eec4320d"

  bottle do
    cellar :any_skip_relocation
    sha256 "96302b0e17bf01c9a1d7ca965919c8d7c1bd6b4d7d01b9a6505bd5ea77cfcaa9" => :high_sierra
    sha256 "96302b0e17bf01c9a1d7ca965919c8d7c1bd6b4d7d01b9a6505bd5ea77cfcaa9" => :sierra
    sha256 "96302b0e17bf01c9a1d7ca965919c8d7c1bd6b4d7d01b9a6505bd5ea77cfcaa9" => :el_capitan
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
