require 'formula'

class PhpVersion < Formula
  homepage  'https://github.com/wilmoore/php-version#simple-php-version-switching'
  url       'https://github.com/wilmoore/php-version/archive/0.12.0.tar.gz'
  sha1      '5398407b97fff2fb898fa66a197de2fe3383ca9a'
  head      'https://github.com/wilmoore/php-version.git'

  def install
    prefix.install Dir['*']
  end

  def caveats;
    <<-EOS.undent
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

        source $(brew --prefix php-version)/php-version.sh && php-version 5

      It is recommended that you install versions of PHP via homebrew as depicted below:

        brew install php56
        brew unlink php56

      Type `php-version --help` for more configuration options.
    EOS
  end
end
