require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Opcache < AbstractPhp54Extension
  init
  homepage 'https://github.com/zend-dev/ZendOptimizerPlus'
  url 'https://github.com/zendtech/ZendOptimizerPlus/archive/v7.0.3.tar.gz'
  sha1 'e03bd1e0286cef4fadf725d4ebf5cc69bbd07bc6'
  head 'https://github.com/zendtech/ZendOptimizerPlus.git'

  depends_on 'pcre'

  def extension_type; "zend_extension"; end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      opcache.memory_consumption=128
      opcache.interned_strings_buffer=8
      opcache.max_accelerated_files=4000
      opcache.revalidate_freq=60
      opcache.fast_shutdown=1
      opcache.enable_cli=1
      opcache.enable_file_override=1
      apc.cache_by_default = false
    EOS
  end
end
