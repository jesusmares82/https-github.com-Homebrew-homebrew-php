require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.3.1/drupal.phar"
  sha256 "88d79bcbfd2627e9840894111c6bc980ebb12b87950600266ae429d7eec4320d"

  bottle do
    cellar :any_skip_relocation
    sha256 "a2e5b3b5fcf5a537fa3473890a87fea88a7295175ade688d7c179049903d2118" => :high_sierra
    sha256 "a2e5b3b5fcf5a537fa3473890a87fea88a7295175ade688d7c179049903d2118" => :sierra
    sha256 "a2e5b3b5fcf5a537fa3473890a87fea88a7295175ade688d7c179049903d2118" => :el_capitan
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
