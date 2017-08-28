require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun-1.98.0.phar"
  sha256 "4e48652f347a48e9b323a0b042d0a97ce1f9ffb7ff48104a9143be217cb8fe63"

  bottle :unneeded

  def phar_file
    "n98-magerun-#{version}.phar"
  end

  def phar_bin
    "n98-magerun"
  end

  test do
    system "#{bin}/n98-magerun", "list"
  end
end
