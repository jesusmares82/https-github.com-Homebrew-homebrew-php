require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Timezonedb < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/timezonedb'
  url 'http://pecl.php.net/get/timezonedb-2013.2.tgz'
  sha1 '8bade3e0c5427ddaa0ba7148cef0e2569bce31ec'
  head 'https://svn.php.net/repository/pecl/timezonedb/trunk/', :using => :svn
  version '2013.2'

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file unless build.include? "without-config-file"
  end

end
