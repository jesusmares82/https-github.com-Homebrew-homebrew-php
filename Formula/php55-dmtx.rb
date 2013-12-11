require 'formula'
require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Dmtx < AbstractPhp55Extension
  init
  homepage 'http://www.libdmtx.org'
  url 'https://github.com/maZahaca/php-dmtx/archive/0.0.2-dev.tar.gz'
  sha1 'b5fc8cc244d29177a35995afd968b8d2ddf22e31'
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
    write_config_file unless build.include? "without-config-file"
  end
end