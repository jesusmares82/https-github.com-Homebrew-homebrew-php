require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Scrypt < AbstractPhp53Extension
  init
  homepage 'https://github.com/DomBlack/php-scrypt'
  url 'https://github.com/DomBlack/php-scrypt/archive/v1.2.tar.gz'
  sha1 '56d1d987b06cc54c2a360ca5a93b84e9f3f0c5c9'
  head 'https://github.com/DomBlack/php-scrypt.git'

  def install
    ENV.universal_binary if build.universal?
    ENV['CFLAGS'] = '-arch i386 -arch x86_64'

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-scrypt"
    system "make"
    prefix.install "modules/scrypt.so"

    write_config_file if build.with? "config-file"
  end
end
