
require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "Deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v4.3.0/deployer.phar"
  version "4.3.0"
  sha256 "26f41009261466a7cd5e850fe96a6c4adcd03a4a8a18aa6322a6d38c49eb9b5b"

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
