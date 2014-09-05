require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.5.tgz'
  sha1 '62d388e07a45cab9eee498e7905c92a7e5d023cc'
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
