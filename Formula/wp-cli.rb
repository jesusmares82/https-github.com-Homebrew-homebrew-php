require 'formula'

class WpCli < Formula
  homepage 'https://github.com/wp-cli/wp-cli/'
  url 'https://github.com/wp-cli/wp-cli/archive/v0.10.2.tar.gz'
  sha1 'd738b48292dd59d989e1cd7071b37f51ef2ebe11'

  def install
    prefix.install Dir['src/*']
    (prefix+'etc/bash_completion.d').install 'utils/wp-completion.bash' => 'wp'
  end

  def test
    system "#{bin}/wp"
  end
end
