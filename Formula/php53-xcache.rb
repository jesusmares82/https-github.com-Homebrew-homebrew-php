require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Xcache < AbstractPhp53Extension
  init
  homepage 'http://xcache.lighttpd.net'
  url 'http://xcache.lighttpd.net/pub/Releases/3.0.1/xcache-3.0.1.tar.bz2'
  sha1 'abd5c1cdff3e2f2207e1d39eb99470ffd48efc0f'

  def extension_type; "extension"; end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/xcache.so"
    write_config_file unless build.include? "without-config-file"
  end
end
