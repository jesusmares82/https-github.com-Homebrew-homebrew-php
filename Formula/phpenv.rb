require 'formula'

class Phpenv < Formula
  homepage 'https://github.com/CHH/phpenv'
  url 'https://github.com/CHH/phpenv/archive/01a2c1e25096f8ff10f2f781428a5d470e1ecaba.tar.gz'
  sha1 '749d430a3c4354b1e27c3101026518689aed51a4'
  head 'https://github.com/CHH/phpenv.git'
  version '01a2c1e'

  option 'skip-install', "Do not run phpenv-install.sh"

  def install
    bin.install 'bin/phpenv-install.sh'
    man1.install 'man/phpenv-install.1'
    doc.install 'man/phpenv-install.1.html'
    system("#{bin}/phpenv-install.sh") unless build.include? 'skip-install'
  end

  def caveats;
    output = "To finish installing phpenv:\n"
    output << " * Run phpenv-install.sh\n" if build.include? 'skip-install'
    output << " * Add ~/.phpenv/bin to your $PATH\n"
    output << " * Add \"eval $(phpenv init -)\" at the end of your ~/.bashrc\n"
    output << " * Restart your shell"
    output
  end
end
