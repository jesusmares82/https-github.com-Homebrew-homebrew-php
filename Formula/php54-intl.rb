require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Intl < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on 'icu4c'

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-icu-dir=#{Formula['icu4c'].opt_prefix}",
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end
end
