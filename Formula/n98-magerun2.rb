require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun2 < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento 2 developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun2-1.3.1.phar"
  sha256 "b9f84024fc80dbd58454007a3b80822ef5029805bad15867930f7def5ad20ecb"

  bottle :unneeded

  def phar_file
    "n98-magerun2-#{version}.phar"
  end

  def phar_bin
    "n98-magerun2"
  end

  test do
    system "#{bin}/n98-magerun2", "list"
  end
end
