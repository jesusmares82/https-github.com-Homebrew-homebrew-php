require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.1/drupal.phar"
  sha256 "d27c8c7283a237c2f610c5ec00b19a228fddaa02ae4dbf815d43490a0ce9e30e"

  bottle do
    cellar :any_skip_relocation
    sha256 "7ed94f13ff6eacfcfc8d1676e4343456d2d402ce576e63951acdbf8685c320be" => :sierra
    sha256 "7ed94f13ff6eacfcfc8d1676e4343456d2d402ce576e63951acdbf8685c320be" => :el_capitan
    sha256 "7ed94f13ff6eacfcfc8d1676e4343456d2d402ce576e63951acdbf8685c320be" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
