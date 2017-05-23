
require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "Deployment tool written in PHP with support for popular frameworks out of the box."
  homepage "https://deployer.org"
  url "https://deployer.org/releases/v5.0.1/deployer.phar"
  version "5.0.1"
  sha256 "a6f2cc4227abe4a069608a81a14f92bfc9428dd0c225af63ddb43cff4ec7a9e5"

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
