require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Http < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/pecl_http'
  url 'http://pecl.php.net/get/pecl_http-1.7.6.tgz'
  sha1 '44e28b6d2d9d352c5b949f14bc4dd612e4365c85'
  head 'http://svn.php.net/repository/pecl/http/trunk/', :using => :svn

  devel do
    url 'http://pecl.php.net/get/pecl_http-2.0.0beta4.tgz'
    version '2.0.0beta4'
    sha1 'f15a7494561c8be16df72a94386c0501a02dbeaa'
  end

  def install
    Dir.chdir "pecl_http-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/http.so"
    write_config_file unless build.include? "without-config-file"
  end
end
