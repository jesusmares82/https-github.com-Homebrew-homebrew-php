require 'formula'

class Boris < Formula
  homepage 'https://github.com/d11wtq/boris/'
  url      'https://github.com/d11wtq/boris/archive/v1.0.6.tar.gz'
  sha1     '40c2babb786e76b7a8e82e21405b71322ef56291'
  head     'https://github.com/d11wtq/boris.git'

  def install
    prefix.install Dir['*']
  end

  test do
    system 'boris', '-h'
  end

  def caveats
    <<-EOS.undent
    Boris depends on the following PHP features:
      * PHP >= 5.3
      * The Readline functions
      * The PCNTL functions
      * The POSIX functions
    EOS
  end
end
