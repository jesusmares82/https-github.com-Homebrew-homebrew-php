require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  desc "PHP extension which provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "http://xdebug.org/files/xdebug-2.3.3.tgz"
  sha256 "b27bd09b23136d242dbc94f4503c98f012a521d5597002c9d463a63c6b0cdfe3"
  head "https://github.com/xdebug/xdebug.git"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
