require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Yaf < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/yaf'
  url 'http://pecl.php.net/get/yaf-2.2.9.tgz'
  sha1 '6640fda6de95185cf898b0116a5136275634c42d'
  head 'https://svn.php.net/repository/pecl/yaf/trunk/'

  depends_on 'pcre'

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
