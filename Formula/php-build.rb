require 'formula'

class PhpBuild < Formula
  homepage 'http://chh.github.com/php-build/'
  url 'https://github.com/CHH/php-build/archive/v0.10.0.tar.gz'
  sha256 '9f3f842608ee7cb3a6a9fcf592a469151fc1e73068d1c2bd6dbd15cac379857c'
  head 'https://github.com/CHH/php-build.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "5080f0dd4caac6cfd31ddc2264d9e3769d611c34d26866ec86023ddca7f34769" => :el_capitan
    sha256 "71a56c627cf57bdd36f77645f2f3e50ff1460de1c079c131e746e39b83a56308" => :yosemite
    sha256 "3f246c48f9163194997128d370ece7a25009da1eb345d2e8a80dc06397ee07d9" => :mavericks
  end

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
