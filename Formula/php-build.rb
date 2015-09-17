require 'formula'

class PhpBuild < Formula
  homepage 'http://chh.github.com/php-build/'
  url 'https://github.com/CHH/php-build/archive/v0.10.0.tar.gz'
  sha256 '9f3f842608ee7cb3a6a9fcf592a469151fc1e73068d1c2bd6dbd15cac379857c'
  head 'https://github.com/CHH/php-build.git'

  depends_on 'wget'
  depends_on 'autoconf' => :build

  def install
    bin.install Dir['bin/php-build']
    share.install Dir['share/php-build']
    man1.install Dir['man/php-build.1']
  end

  test do
    system "php-build --definitions"
  end

  def caveats; <<-EOS.undent
    Tidy is enabled by default which will only work
    on 10.7. Be sure to disable or patch Tidy for
    earlier versions of OS X.
    EOS
  end
end
