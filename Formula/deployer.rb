
require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Deployer < AbstractPhpPhar
  init
  desc "Deployment tool for PHP projects, much like Capistrano is to Ruby."
  homepage "https://deployer.org/"
  url "https://deployer.org/releases/v4.0.0/deployer.phar"
  version "4.0.0"
  sha256 "9f43bb1b49a461bfebcbd7e75acf881c7ad3b7aedbeb15e03c0e5587db15502e"

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
