require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun2 < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento 2 developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun2-1.4.0.phar"
  sha256 "63449a78866a02bb42d350f96102e7a4d9629a3893e6c5db784ce6d23160fb9b"

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
