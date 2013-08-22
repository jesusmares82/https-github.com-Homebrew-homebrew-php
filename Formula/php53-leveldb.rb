require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Leveldb < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/leveldb'
  url 'http://pecl.php.net/get/leveldb-0.1.3.tgz'
  sha1 'b2a63425e6591b4334e43a447403b70a5f6db7e3'
  head 'https://github.com/reeze/php-leveldb.git'

  depends_on 'leveldb'

  def install
    Dir.chdir "leveldb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-leveldb=#{Formula.factory('leveldb').opt_prefix}"

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/leveldb.so"
    write_config_file unless build.include? "without-config-file"
  end
end
