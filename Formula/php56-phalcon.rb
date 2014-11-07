require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Phalcon < AbstractPhp56Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/archive/phalcon-v1.3.3.tar.gz'
  sha1 '9380442a83e133b4af37b017b6098317f00516ff'
  head 'https://github.com/phalcon/cphalcon.git'

  depends_on 'pcre'

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir 'build/64bits'
    else
      Dir.chdir 'build/32bits'
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
