require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Timezonedb < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/timezonedb'
  url 'http://pecl.php.net/get/timezonedb-2014.2.tgz'
  sha1 'c676ffbb8e4928269f27f3ae8275411e35a67b33'
  head 'https://svn.php.net/repository/pecl/timezonedb/trunk/'

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end

end
