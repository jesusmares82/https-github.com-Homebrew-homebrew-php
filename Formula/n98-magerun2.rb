require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun2 < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento 2 developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun2-1.3.0.phar"
  sha256 "2787cac4c4a3a69166fb5ec0bd540ae8dd66170239dc083acae0fdb449678a0b"

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
