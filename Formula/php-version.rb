require 'formula'

class PhpVersion < Formula
  homepage  'https://github.com/wilmoore/php-version#simple-php-version-switching'
  url       'https://github.com/wilmoore/php-version/archive/0.10.4.tar.gz'
  sha1      '57afc04e73475465fb28fd446e97478aecae0e9a'
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

      Type `php-version --help` for more configuration options (i.e. how to add extra PHP installation paths).
    EOS
  end
end
