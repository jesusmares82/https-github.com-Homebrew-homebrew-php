require 'formula'
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  homepage 'http://www.libdmtx.org'
  url 'https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz'
  sha256 '864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26'
  head 'https://github.com/maZahaca/php-dmtx.git'

  depends_on 'libdmtx'
  depends_on 'php56-imagick'
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
