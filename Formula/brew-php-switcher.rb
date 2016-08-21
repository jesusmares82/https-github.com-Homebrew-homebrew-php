class BrewPhpSwitcher < Formula
  desc "Switch Apache & CLI configs between PHP versions"
  homepage "https://github.com/philcook/php-switcher"
  url "https://github.com/philcook/brew-php-switcher/archive/1.6.tar.gz"
  sha256 "569b5ab5451bcfa784ff94141359fe4d80720c2fe4bf2d67f8fea33f5f05956e"
  head "https://github.com/philcook/brew-php-switcher.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "22836f2e584dad5894ededc1854b8efd9273160b7c2534545181c832c2788131" => :el_capitan
    sha256 "44c30fd96f6bbf554895f1abf3216105e94a7d3ec1cdd7b38da2fbe1c0262f1f" => :yosemite
    sha256 "44c30fd96f6bbf554895f1abf3216105e94a7d3ec1cdd7b38da2fbe1c0262f1f" => :mavericks
  end

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

    You can select php version 53, 54, 55, 56, 70 or 71.
    EOS
  end

  test do
    system "brew-php-switcher"
  end
end
