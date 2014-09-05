require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Chdb < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/chdb'
  url 'http://pecl.php.net/get/chdb-1.0.2.tgz'
  sha1 '476a6e84dd97c1ec24538edef9e3ba145256346e'
  head 'https://github.com/lcastelli/chdb', :using => :git

  depends_on 'libcmph'

  def install
    Dir.chdir "chdb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/chdb.so"
    write_config_file if build.with? "config-file"
  end
end
