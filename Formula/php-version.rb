class PhpVersion < Formula
  desc "stupid simple PHP version management"
  homepage "https://github.com/wilmoore/php-version#simple-php-version-switching"
  url "https://github.com/wilmoore/php-version/archive/0.12.0.tar.gz"
  sha256 "6f432d836394fecfedcf1db926fa540a4be542feea1ddf56e78d38b1a8ab8798"
  head "https://github.com/wilmoore/php-version.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "34b62e9c82ac7a67a67ff77e39d2f05dc496b595879cea5cf78a222ceb924735" => :el_capitan
    sha256 "59fbb783d2792408701488d75c98ed42905ec4659614d5519234cc836e9fa497" => :yosemite
    sha256 "c73168717e6c1b46c8bbd6b9db20a10b65cc420f2e2872ca609d480bb53b0bdf" => :mavericks
  end

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
