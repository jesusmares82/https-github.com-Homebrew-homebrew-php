require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Varnish < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/varnish'
  url 'http://pecl.php.net/get/varnish-1.1.1.tgz'
  sha1 'f05a556102a4e3e14e7714b86a1b69e7e5d5ffc2'

  def install
    Dir.chdir "varnish-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/varnish.so"
    write_config_file if build.with? "config-file"
  end
end
