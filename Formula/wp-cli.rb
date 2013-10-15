require 'formula'

class WpCli < Formula
  homepage 'https://github.com/wp-cli/wp-cli'
  head 'https://github.com/wp-cli/wp-cli.git'
  url 'https://github.com/wp-cli/wp-cli/archive/v0.12.1.tar.gz'
  sha1 'b334f1728fec439f8db083f4ee335c707cd36649'

  option 'without-bash-completion', "Don't install bash completion"
  option 'without-package-index', "Don't add package index repository (http://wp-cli.org/package-index)"

  depends_on 'composer'

  def install
    system "#{HOMEBREW_PREFIX}/bin/composer install"
    prefix.install Dir['*']

    unless build.without? 'bash-completion'
      (prefix + 'etc/bash_completion.d').install "#{prefix}/utils/wp-completion.bash"
    end
    unless build.without? 'package-index'
      system "#{HOMEBREW_PREFIX}/bin/composer config --file='#{prefix}/composer.json' repositories.wp-cli composer http://wp-cli.org/package-index/"
    end
  end

  def test
    system "#{bin}/wp --info"
  end
end
