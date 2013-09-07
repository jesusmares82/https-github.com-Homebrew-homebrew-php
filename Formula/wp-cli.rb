require 'formula'

class WpCli < Formula
  homepage 'https://github.com/wp-cli/wp-cli'
  head 'https://github.com/wp-cli/wp-cli.git'
  url 'https://github.com/wp-cli/wp-cli/archive/v0.11.2.tar.gz'
  sha1 '95142ab585f5237b58fe878f70ca85331e098933'

  option 'without-bash-completion', "Don't install bash completion"

  depends_on 'composer'

  def install
    system "#{HOMEBREW_PREFIX}/bin/composer install"
    prefix.install Dir['*']

    unless build.without? 'bash-completion'
      (prefix + 'etc/bash_completion.d').install 
        "#{prefix}/utils/wp-completion.bash"
    end
  end

  def test
    system "#{bin}/wp --info"
  end
end
