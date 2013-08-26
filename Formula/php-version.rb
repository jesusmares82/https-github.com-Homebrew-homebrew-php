require 'formula'

class PhpVersion < Formula
  homepage  'http://wilmoore.github.com/php-version'
  url       'https://github.com/wilmoore/php-version/archive/0.9.10.tar.gz'
  sha1      '65092d0f1774294accbbac93245141d2cfb0e81b'
  head      'https://github.com/wilmoore/php-version.git'

  def install
    prefix.install Dir['*']
  end

  def caveats;
    <<-EOS.undent
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

      test -d $(brew --prefix php-version)
        && source $(brew --prefix php-version)/php-version.sh
        && php-version 5 >/dev/null
        
      Type `php-version --help` for more configuration options such as how to add extra PHP installation paths.
    EOS
  end
end
