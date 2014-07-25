require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ev < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/ev'
  url 'http://pecl.php.net/get/ev-0.2.10.tgz'
  sha1 'c096e13752cd919a5af8d300f71134492eae8e01'
  head 'https://bitbucket.org/osmanov/pecl-ev.git'

  depends_on 'libev'

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula['libev'].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
