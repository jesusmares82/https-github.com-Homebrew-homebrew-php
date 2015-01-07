require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaf < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/yaf'
  url 'http://pecl.php.net/get/yaf-2.3.3.tgz'
  sha1 'dc2bf8d875a659b0159abea317b87e4651dc50d9'
  head 'https://svn.php.net/repository/pecl/yaf/trunk/'

  depends_on 'pcre'

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
