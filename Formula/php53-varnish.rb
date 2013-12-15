require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Varnish < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/varnish'
  url 'http://pecl.php.net/get/varnish-1.1.1.tgz'
  sha1 '9cc3b308c6dccb4bbf376fce4bcc2268aa7a7c1d'

  def install
    Dir.chdir "varnish-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/varnish.so"
    write_config_file unless build.include? "without-config-file"
  end
end
