require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage 'http://phalconphp.com/'
  url 'https://github.com/phalcon/cphalcon/archive/phalcon-v1.3.2.tar.gz'
  sha1 '64eea8e384363a5582a59a910b1327dc97b7d355'
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
