require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Xdebug < AbstractPhp53Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.3.tgz'
  sha1 '045dee86f69051d7944da594db648b337a97f48a'
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
    write_config_file unless build.include? "without-config-file"
  end
end
