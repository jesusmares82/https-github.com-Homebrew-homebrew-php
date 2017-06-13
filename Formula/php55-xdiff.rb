require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdiff < AbstractPhp55Extension
  init
  desc "File differences and patches"
  homepage "https://pecl.php.net/package/xdiff"
  url "https://pecl.php.net/get/xdiff-1.5.2.tgz"
  sha256 "ebe72b887fcd2296f1e4032d476a8a463803ccfb0b34b403be8433daf3cfd81d"

  depends_on "libxdiff"

  def install
    Dir.chdir "xdiff-#{version}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/xdiff.so"
    write_config_file if build.with? "config-file"
  end
end
