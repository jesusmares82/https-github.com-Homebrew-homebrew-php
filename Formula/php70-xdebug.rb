require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "http://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.4.0RC2.tgz"
  sha256 "d09bf890f50178d083291288d9dea34a90a95bd8e9cbc9755d14a8e7ebe9d6d0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
  end

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
