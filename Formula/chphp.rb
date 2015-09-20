class Chphp < Formula
  desc "Changes the current PHP version"
  homepage "https://github.com/marcosdsanchez/chphp"
  url "https://github.com/marcosdsanchez/chphp/archive/v0.0.1.tar.gz"
  sha256 "27b170b5d59a1e5c62682a08621bf8c42aa44a4f7c2b3517fab0620d78a4e6f7"
  head "https://github.com/marcosdsanchez/chphp.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "68f364c4504e18aa0c1518a9e2ea50466727c72cd46d82a5533569e4c00629c6" => :el_capitan
    sha256 "a9aec36aec4b8ed1bf58c4cb8c7800ceaf8c4a7249c2d5bb27cc038db479d07b" => :yosemite
    sha256 "4b9858eb02d78c6cc4ad9e5d59a251a63cebfe39756d7f5ed46a2cb1a79b6989" => :mavericks
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats; <<-EOS.undent
    Add the following to the ~/.bashrc or ~/.zshrc file:

      source #{opt_prefix}/share/chphp/chphp.sh

    By default chphp will search for Rubies installed into /opt/rubies/ or
    ~/.rubies/. For non-standard installation locations, simply set the RUBIES
    variable after loading chphp.sh:

      PHP_VERSIONS=(
        /opt/php-5.3.5
      )

    To enable auto-switching of Php versions specified by .php-version files,
    add the following to ~/.bashrc or ~/.zshrc:

      source #{opt_prefix}/share/chphp/auto.sh
    EOS
  end

  test do
    system "chphp-exec", "--version"
  end
end
