require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yp < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/yp'
  url 'http://pecl.php.net/get/yp-1.0.1.tgz'
  sha1 'b678ae5b89b8d5d5e78c8474cbb24c7e3fe3e83a'
  head 'https://git.php.net:/repository/pecl/networking/yp.git'

  def install
    Dir.chdir "yp-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yp.so"
    write_config_file if build.with? "config-file"
  end
end
