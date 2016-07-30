require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.0.tar.gz"
  sha256 "7303990809bcd1a716e886bcfacd0e7afc7ef1f1104df123e680c8d7cd088ce0"
  head "https://github.com/phalcon/cphalcon.git"

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php7/64bits"
    else
      Dir.chdir "build/php7/32bits"
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
