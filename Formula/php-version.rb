require 'formula'

class PhpVersion < Formula
  homepage  'https://github.com/wilmoore/php-version#simple-php-version-switching'
  url       'https://github.com/wilmoore/php-version/archive/0.11.0.tar.gz'
  sha1      '2dc9efaac24d7f5368083c3ad9d5c6415a717cb5'
  head      'https://github.com/wilmoore/php-version.git'

  def install
    prefix.install Dir['*']
  end

  def caveats;
    <<-EOS.undent
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

        source $(brew --prefix php-version)/php-version.sh && php-version 5

      It is recommended that you install versions of PHP via homebrew as depicted below:

        brew install php55
        brew unlink php55

      Type `php-version --help` for more configuration options.
    EOS
  end
end
