require "formula"

class BrewPhpSwitcher < Formula
  homepage "https://github.com/philcook/brew-php-switcher"
  url 'https://github.com/philcook/brew-php-switcher/archive/v1.3.tar.gz'
  sha1 'c72670804305fc2f389c579a8355b07f4ebe5b23'
  head 'https://github.com/philcook/brew-php-switcher.git'

  def install
    bin.install "phpswitch.sh"
    sh = libexec + "brew-php-switcher"
    sh.write("#!/usr/bin/env sh\n\nsh #{bin}/phpswitch.sh $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    To run brew php switcher do the following:
      "brew-php-switcher 53".

    You can select php version 53,54,55 or 56.
    EOS
  end
end
