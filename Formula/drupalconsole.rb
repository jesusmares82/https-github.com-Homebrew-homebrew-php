require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.2.0/drupal.phar"
  sha256 "7bba25997474182a5e53e6aba706defdb2db311bfc7bdd3f45e18b7ae14bc156"

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
