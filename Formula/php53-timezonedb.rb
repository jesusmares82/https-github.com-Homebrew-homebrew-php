require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Timezonedb < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/timezonedb'
  url 'http://pecl.php.net/get/timezonedb-2013.8.tgz'
  sha1 '93f6027001c2e0c48bd42669f7dfd3d2fa67ee5b'
  head 'https://svn.php.net/repository/pecl/timezonedb/trunk/'

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
