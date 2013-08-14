require 'formula'

class WpCli < Formula
  homepage 'https://github.com/wp-cli/wp-cli'
  head 'https://github.com/wp-cli/wp-cli.git'
  url 'https://github.com/wp-cli/wp-cli/archive/v0.11.1.tar.gz'
  sha1 'a64b51d80574a7603d2c6a8c23289911b93bb8c6'

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
