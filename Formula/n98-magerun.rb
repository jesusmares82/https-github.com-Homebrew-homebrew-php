require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class N98Magerun < AbstractPhpPhar
  init
  desc "Swiss army knife for Magento developers, sysadmins and devops."
  homepage "http://magerun.net/"
  url "https://files.magerun.net/n98-magerun-1.97.27.phar"
  sha256 "86e5b6963ca19a78e5c8626ec90710a3967963a86ecef3d4852b5a2e617cf5be"

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
