require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Scrypt < AbstractPhp70Extension
  init
  desc "PHP wrapper for the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.4.2.tar.gz"
  sha256 "f187076caa8eeb0f5d9992fbc2045b5dff11652f5ce93ccdf3a792ac98b43622"
  head "https://github.com/DomBlack/php-scrypt.git"

  def install
    ENV.universal_binary if build.universal?
    ENV["CFLAGS"] = "-arch i386 -arch x86_64"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-scrypt"
    system "make"
    prefix.install "modules/scrypt.so"

    write_config_file if build.with? "config-file"
  end
end
