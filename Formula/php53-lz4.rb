require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Lz4 < AbstractPhp53Extension
  init
  homepage 'https://code.google.com/p/lz4/'
  url 'https://github.com/kjdev/php-ext-lz4/archive/0.2.0.tar.gz'
  sha1 '5622f65c1f357b7cf5cd7542fad811f582151883'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
