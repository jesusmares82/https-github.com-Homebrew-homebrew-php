require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Snappy < AbstractPhp53Extension
  init
  homepage 'http://code.google.com/p/php-snappy/'
  url 'https://php-snappy.googlecode.com/files/php-snappy-0.0.2.tar.gz'
  sha1 '8537def4d9358830c26119e321a9080db1228c78'
  head 'http://php-snappy.googlecode.com/svn/trunk/'

  depends_on 'snappy'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/snappy.so"
    write_config_file if build.with? "config-file"
  end
end
