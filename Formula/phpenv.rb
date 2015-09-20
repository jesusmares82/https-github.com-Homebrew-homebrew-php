class Phpenv < Formula
  desc "Thin Wrapper around rbenv for PHP version managment"
  homepage "https://github.com/CHH/phpenv"
  url "https://github.com/CHH/phpenv/archive/01a2c1e25096f8ff10f2f781428a5d470e1ecaba.tar.gz"
  version "01a2c1e"
  sha256 "0e0c89fc1f42fe27848446f974348f2a0f6eda7d93f8ea72cc17920fa26f4b92"
  head "https://github.com/CHH/phpenv.git"

  option "without-install", "Do not run phpenv-install.sh"

  def install
    bin.install "bin/phpenv-install.sh"
    man1.install "man/phpenv-install.1"
    doc.install "man/phpenv-install.1.html"
    system("#{bin}/phpenv-install.sh") if build.with? "install"
  end

  def caveats
    output = "To finish installing phpenv:\n"
    output << " * Run phpenv-install.sh\n" if build.without? "install"
    output << " * Add ~/.phpenv/bin to your $PATH\n"
    output << " * Add \"eval $(phpenv init -)\" at the end of your ~/.bashrc\n"
    output << " * Restart your shell"
    output
  end

  test do
    assert File.exist?("#{bin}/phpenv-install.sh")
  end
end
