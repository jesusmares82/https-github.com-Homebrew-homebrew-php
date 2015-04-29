class BrewPhpSwitcher < Formula
  url "https://github.com/philcook/brew-php-switcher/archive/v1.4.tar.gz"
  homepage "https://github.com/philcook/php-switcher"
  sha256 "299950a2d3cfa70468aa9569f10c8d50eff68ec069c7a884898677e6799932bb"
  head "https://github.com/philcook/brew-php-switcher.git"

  def install
    bin.install "phpswitch.sh"
    sh = libexec + "brew-php-switcher"
    sh.write("#!/usr/bin/env sh\n\nsh #{bin}/phpswitch.sh $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "brew-php-switcher"
  end

  def caveats; <<-EOS.undent
    To run brew php switcher do the following:
      "brew-php-switcher 53".

    You can select php version 53, 54, 55, or 56.
    EOS
  end
end
