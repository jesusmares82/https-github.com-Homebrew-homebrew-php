require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Runkit < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.runkit.php'
  url 'https://github.com/zenovich/runkit/archive/5e179e978af79444d3c877d5681ea91d15134a01.tar.gz'
  sha1 'c069e88e6459df09a8a8f8c0e70de61f8e971914'
  head 'https://github.com/zenovich/runkit.git'
  version '5e179e9'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
