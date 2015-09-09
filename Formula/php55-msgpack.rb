require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Msgpack < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/msgpack'
  url 'http://pecl.php.net/get/msgpack-0.5.7.tgz'
  sha1 '584b772b5e90e957e14a73ab107e69bafaa2021a'
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
