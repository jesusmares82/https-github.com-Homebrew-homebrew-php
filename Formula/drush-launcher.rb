require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class DrushLauncher < AbstractPhpPhar
  desc "A small wrapper around Drush for your global $PATH."
  homepage "https://github.com/drush-ops/drush-launcher"
  url "https://github.com/drush-ops/drush-launcher/releases/download/0.4.3/drush.phar"
  sha256 "7da7bf2552da681a1a87788d4c4a34abdc0ace47bc9ddc395d8fc88480e13dde"

  def install
    bin.install "drush.phar" => "drush"
  end

  test do
    system "#{bin}/drush", "--drush-launcher-version"
  end

  conflicts_with "drush", :because => "because both provide a 'drush' executable"
end
