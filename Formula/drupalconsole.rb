require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.2/drupal.phar"
  sha256 "e3845ccb7eb014483a535eb4919de944aefb5b32a3c57cf89d2ed999f6b82e59"

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
