require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Lzf < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/lzf'
  url 'http://pecl.php.net/get/LZF-1.6.2.tgz'
  sha1 '9e24976b65a000ea09f0860daa1de13d5de4f022'
  head 'http://svn.php.net/repository/pecl/lzf/trunk/'

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
