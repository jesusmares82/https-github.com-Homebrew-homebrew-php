require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Xdebug < AbstractPhp55Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.4.tgz'
  sha1 '586a7f24330f5139b7b8cec8ed96b99f3d3a753d'
  head 'https://github.com/xdebug/xdebug.git'

  def extension_type; "zend_extension"; end

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
