require 'formula'

class PhpInstall < Formula
  homepage 'https://github.com/marcosdsanchez/php-install#readme'
  url 'https://github.com/marcosdsanchez/php-install/archive/v0.0.1.tar.gz'
  sha256 '97f1124ca0b200234dce4bec307e153768f803c08768a231ed3a3ff2864c36c3'

  head 'https://github.com/marcosdsanchez/php-install.git'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
