require "formula"

class BrewPhpSwitcher < Formula
  homepage "https://github.com/philcook/php-switcher"
  url 'https://github.com/philcook/php-switcher/archive/f4f6b22916ee87464464464d7233dd8bc04e940c.tar.gz'
  sha1 'a048eb62eca90a8ecb34f88bbb0df87426203f57'
  version "f4f6b22"

  def install
    bin.install "phpswitch.sh"
    sh = libexec + "brew-php-switcher"
    sh.write("#!/usr/bin/env sh\n\nsh #{bin}/phpswitch.sh $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
