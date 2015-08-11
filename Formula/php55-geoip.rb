require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geoip < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/geoip'
  url 'http://pecl.php.net/get/geoip-1.1.0.tgz'
  sha1 '72475f10cb3549eac7d790ab6ae1869f89c6dae0'
  head 'https://svn.php.net/repository/pecl/geoip/trunk/'

  depends_on 'geoip'

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula['geoip'].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
