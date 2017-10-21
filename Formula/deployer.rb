require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "Deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v6.0.3/deployer.phar"
  sha256 "8a0054535c922f7a4e10449c62f9d6be79f2cb34c2fe9137f78f9fff89b44970"

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
