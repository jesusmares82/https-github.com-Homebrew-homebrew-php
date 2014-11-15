require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.6.tgz'
  sha1 '829b7e37eb8c198bdb4924ad337741ea84cb81a1'
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
