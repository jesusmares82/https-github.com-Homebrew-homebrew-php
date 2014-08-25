require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Phpiredis < AbstractPhp55Extension
  init
  homepage 'https://github.com/nrk/phpiredis'
  url 'https://github.com/nrk/phpiredis/archive/master.tar.gz'
  version '1.0'
  head 'https://github.com/nrk/phpiredis.git'

  depends_on "hiredis"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--enable-phpiredis"
    args << "--with-hiredis-dir=#{Formula['hiredis'].opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/phpiredis.so"
    write_config_file if build.with? "config-file"
  end
end
