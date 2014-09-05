require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Msgpack < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/msgpack'
  url 'http://pecl.php.net/get/msgpack-0.5.5.tgz'
  sha1 '67c83c359619e8f7f153a83bdf3708c5ff39e491'
  head 'https://github.com/msgpack/msgpack-php.git'

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
