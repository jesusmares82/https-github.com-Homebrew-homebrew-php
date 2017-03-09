
require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "A deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v4.2.1/deployer.phar"
  version "4.2.1"
  sha256 "4d2caa8f1f66aee77de64ba7cfcf4ab4acb37f3c38d634d3da16c9d935526b6d"

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
