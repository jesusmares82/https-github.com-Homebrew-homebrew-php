class BrewPhpSwitcher < Formula
  desc "Brew PHP switcher is a simple script to switch your Apache and CLI configs quickly between major versions of PHP."
  url "https://github.com/philcook/brew-php-switcher/archive/v1.5.tar.gz"
  homepage "https://github.com/philcook/php-switcher"
  sha256 "e5ead8b188a54d270b3a12bdcbae4a97c808e9d2ee72708597abffb8b4e8b591"
  head "https://github.com/philcook/brew-php-switcher.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d1a75a5eb4fd0a1641b520620ad8cf9d661eacbdc780dea906e5a13aeb12e1ff" => :yosemite
    sha256 "b3f761057a8d9b32530dcadac8c319e353c6d73b13a7a487f073ca629c41d7d4" => :mavericks
    sha256 "b051cef58b060aa987b4a7f9b8d6f07e0e996aa7b2e3dc47ae7d80e62784c966" => :mountain_lion
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
