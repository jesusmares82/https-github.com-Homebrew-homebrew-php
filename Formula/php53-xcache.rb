require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xcache < AbstractPhp53Extension
  init
  homepage 'http://xcache.lighttpd.net'
  url 'http://xcache.lighttpd.net/pub/Releases/3.1.0/xcache-3.1.0.tar.bz2'
  sha1 'db30f642de9bc97538fe4f85940e8a69a1a365c8'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/xcache.so"
    write_config_file if build.with? "config-file"
  end
end
