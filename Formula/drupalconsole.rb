require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/drupal-console-launcher/releases/download/1.0.0-rc15/drupal.phar"
  sha256 "e07ff95cecc05ce7866bad18dcd75ac587961831a485316692214e1176fa025d"

  bottle do
    cellar :any_skip_relocation
    rebuild 3
    sha256 "77491a2ecefb46d1d72f9f800a26952106c084a941bdc74ae916ed3b788422fe" => :sierra
    sha256 "881f142885b120d4e112738a634b2cf30b6f81e1808bccbd08b8fc98e937a779" => :el_capitan
    sha256 "881f142885b120d4e112738a634b2cf30b6f81e1808bccbd08b8fc98e937a779" => :yosemite
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "#{bin}/drupal", "--version"
  end
end
