require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Yaf < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/yaf'
  url 'http://pecl.php.net/get/yaf-2.3.1.tgz'
  sha1 'cde4c0f28d43401cf18d5a6e682b77333bdeafa3'
  head 'https://svn.php.net/repository/pecl/yaf/trunk/'

  depends_on 'pcre'

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
