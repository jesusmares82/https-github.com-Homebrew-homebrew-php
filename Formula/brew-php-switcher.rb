class BrewPhpSwitcher < Formula
  desc "Brew PHP switcher is a simple script to switch your Apache and CLI configs quickly between major versions of PHP."
  url "https://github.com/philcook/brew-php-switcher/archive/v1.5.tar.gz"
  homepage "https://github.com/philcook/php-switcher"
  sha256 "e5ead8b188a54d270b3a12bdcbae4a97c808e9d2ee72708597abffb8b4e8b591"
  head "https://github.com/philcook/brew-php-switcher.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "9c0f9771601d2bc5cdab7d940f4834d0bfc96f73e83b9d4131d2af83b1bd5109" => :el_capitan
    sha256 "4cde0032b3f45c120d972b21475f6ad80d6d2d2779c8a3bb50db4f1a83f062e2" => :yosemite
    sha256 "62b0dde91201697e02d4baff60907c6b12d4c6b82793d731f54ec60bdae5df48" => :mavericks
  end

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
