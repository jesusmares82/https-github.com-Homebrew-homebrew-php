require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libevent < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/libevent'
  url 'http://pecl.php.net/get/libevent-0.0.5.tgz'
  sha1 '0817616ef02a5ab2bbc804dad121239391578956'
  head 'http://svn.php.net/repository/pecl/libevent/trunk/'

  depends_on 'libevent'

  def install
    Dir.chdir "libevent-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent=#{Formula['libevent'].opt_prefix}"
    system "make"
    prefix.install "modules/libevent.so"
    write_config_file if build.with? "config-file"
  end
end
