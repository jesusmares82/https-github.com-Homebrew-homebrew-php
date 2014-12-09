require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55MysqlndMs < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/mysqlnd_ms'
  url 'http://pecl.php.net/get/mysqlnd_ms-1.4.2.tgz'
  sha1 'b074ee9f696ec17422638e1d554a0665320f4df9'
  head 'https://svn.php.net/repository/pecl/mysqlnd_ms/trunk/'

  def extension
    "mysqlnd_ms"
  end


  def install
    Dir.chdir extension + "-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mysqlnd-ms"

    system "make"
    prefix.install "modules/" + extension + ".so"
    write_config_file if build.with? "config-file"
  end
end
