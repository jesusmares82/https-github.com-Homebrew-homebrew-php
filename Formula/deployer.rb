
require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "A deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v4.0.2/deployer.phar"
  version "4.0.2"
  sha256 "4d5f75c0209d557cf7efac0f2830b9054a2ab40ce97c3f58ade41d7846594b47"

  bottle :unneeded

  def phar_file
    "deployer.phar"
  end

  def phar_bin
    "dep"
  end

  test do
    system "#{bin}/dep", "list"
  end
end
