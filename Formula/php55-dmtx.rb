require 'formula'
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  homepage 'http://www.libdmtx.org'
  url 'https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz'
  sha1 '98a5712cdcfd4273fffb66f0372e3a0027d36d29'
  head 'https://github.com/maZahaca/php-dmtx.git'

  depends_on 'libdmtx'
  depends_on 'php55-imagick'
  depends_on 'pkg-config' => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w(modules/dmtx.so)
    write_config_file if build.with? "config-file"
  end
end
