require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc15/drupal.phar"
  sha256 "e07ff95cecc05ce7866bad18dcd75ac587961831a485316692214e1176fa025d"

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
