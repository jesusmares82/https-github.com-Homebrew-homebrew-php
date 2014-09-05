require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timezonedb < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/timezonedb'
  url 'http://pecl.php.net/get/timezonedb-2014.6.tgz'
  sha1 'ac6afc8a2ed4b8e531857ba72f7fd6b529e85fd3'
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
