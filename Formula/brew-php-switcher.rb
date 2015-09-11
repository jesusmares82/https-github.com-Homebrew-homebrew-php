class BrewPhpSwitcher < Formula
  url "https://github.com/philcook/brew-php-switcher/archive/v1.5.tar.gz"
  homepage "https://github.com/philcook/php-switcher"
  sha256 "e5ead8b188a54d270b3a12bdcbae4a97c808e9d2ee72708597abffb8b4e8b591"
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

    You can select php version 53, 54, 55, 56 or 70.
    EOS
  end
end
