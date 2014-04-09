require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Timezonedb < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/timezonedb'
  url 'http://pecl.php.net/get/timezonedb-2013.9.tgz'
  sha1 '2eca11ebd81ba1d3e649e6289506ed0442c23e1f'
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
