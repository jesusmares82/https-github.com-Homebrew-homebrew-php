require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xcache < AbstractPhp56Extension
  init
  homepage 'http://xcache.lighttpd.net'
  url 'http://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.bz2'
  sha256 '7d12a3cbd5f729b70f9226ac19406d11219f1c5f5e82b3bbb43ea9460cbf6cbd'

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
