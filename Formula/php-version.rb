class PhpVersion < Formula
  desc "stupid simple PHP version management"
  homepage "https://github.com/wilmoore/php-version#simple-php-version-switching"
  url "https://github.com/wilmoore/php-version/archive/0.12.0.tar.gz"
  sha256 "6f432d836394fecfedcf1db926fa540a4be542feea1ddf56e78d38b1a8ab8798"
  head "https://github.com/wilmoore/php-version.git"

  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<-EOS.undent
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

        source $(brew --prefix php-version)/php-version.sh && php-version 5

      It is recommended that you install versions of PHP via homebrew as depicted below:

        brew install php56
        brew unlink php56

      Type `php-version --help` for more configuration options.
    EOS
  end

  test do
    assert File.exist?("#{prefix}/php-version.sh")
  end
end
