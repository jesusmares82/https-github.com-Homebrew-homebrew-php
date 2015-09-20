class Chphp < Formula
  desc "Changes the current PHP version"
  homepage "https://github.com/marcosdsanchez/chphp"
  url "https://github.com/marcosdsanchez/chphp/archive/v0.0.1.tar.gz"
  sha256 "27b170b5d59a1e5c62682a08621bf8c42aa44a4f7c2b3517fab0620d78a4e6f7"
  head "https://github.com/marcosdsanchez/chphp.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "3d945c5a0fefa360dee8b1f0ea1cee95a4567b6c907f09c2cb0c77ab2e32c44c" => :el_capitan
    sha256 "f5f5200009b9f4a6fa7ed20dfce3a232c98f0d8a338dc493cef6e047c1342c10" => :yosemite
    sha256 "b25f0ab4c5ffb07b15c8bff165a2e6ad8869854b1e65a2d05e87aa8df2f1fffe" => :mavericks
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
