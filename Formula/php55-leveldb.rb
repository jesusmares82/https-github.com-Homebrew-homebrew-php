require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Leveldb < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/leveldb'
  url 'http://pecl.php.net/get/leveldb-0.1.4.tgz'
  sha1 '9a15fb0105516533c38de32dc2a1164f9620e046'
  head 'https://github.com/reeze/php-leveldb.git'

  depends_on 'leveldb'

  def install
    Dir.chdir "leveldb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-leveldb=#{Formula['leveldb'].opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/leveldb.so"
    write_config_file if build.with? "config-file"
  end
end
