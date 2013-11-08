require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Yaz < AbstractPhp53Extension
  init
  homepage 'http://www.indexdata.com/phpyaz'
  url 'http://pecl.php.net/get/yaz-1.1.6.tgz'
  sha1 '6add3d6dda5a676cdf74378ab968fd64e348c91f'
  version '1.1.6'
  
  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file unless build.include? "without-config-file"
  end
end
