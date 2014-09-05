require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/igbinary'
  url 'http://pecl.php.net/get/igbinary-1.1.1.tgz'
  sha1 'cebe34d18dd167a40a712a6826415e3e5395ab27'
  head 'https://github.com/igbinary/igbinary.git'

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "rm apc_serializer.h"
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w(hash.h hash_function.h igbinary.h php_igbinary.h)
    prefix.install %w(modules/igbinary.so)
    write_config_file if build.with? "config-file"
  end
end
