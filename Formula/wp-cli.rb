require 'formula'

class WpCli < Formula
  homepage 'https://github.com/wp-cli/wp-cli/'
  url 'https://github.com/wp-cli/wp-cli.git', :tag => 'v0.8.0'
  version '0.8.0'
  head 'https://github.com/wp-cli/wp-cli.git'

  def install
    prefix.install Dir['src/*']
    (prefix+'etc/bash_completion.d').install 'utils/wp-completion.bash' => 'wp'
  end

  def test
    system "#{bin}/wp"
  end
end