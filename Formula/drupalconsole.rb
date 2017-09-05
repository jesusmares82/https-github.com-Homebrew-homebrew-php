require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.2/drupal.phar"
  sha256 "e3845ccb7eb014483a535eb4919de944aefb5b32a3c57cf89d2ed999f6b82e59"

  bottle do
    cellar :any_skip_relocation
    sha256 "9941992a509368b6afb7519c046d33e953167608352fac58517d7d0f02503825" => :sierra
    sha256 "9941992a509368b6afb7519c046d33e953167608352fac58517d7d0f02503825" => :el_capitan
    sha256 "9941992a509368b6afb7519c046d33e953167608352fac58517d7d0f02503825" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
