require 'formula'

class Boris < Formula
  homepage 'https://github.com/d11wtq/boris/'
  url      'https://github.com/d11wtq/boris/archive/v1.0.5.tar.gz'
  sha1     '5e8667fab1c05be53cab857b661c35f4035da2cb'
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
