require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Opcache < AbstractPhp55Extension
  init
  homepage 'https://github.com/zend-dev/ZendOptimizerPlus'
  url 'https://github.com/zend-dev/ZendOptimizerPlus/archive/v7.0.2.tar.gz'
  sha1 'f35625d237f8dd2f6a01e50e3062657fce9b8be4'
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
    write_config_file unless build.include? "without-config-file"
  end

  def config_file
    super + <<-EOS.undent
      zend_optimizerplus.memory_consumption=128
      zend_optimizerplus.interned_strings_buffer=8
      zend_optimizerplus.max_accelerated_files=4000
      zend_optimizerplus.revalidate_freq=60
      zend_optimizerplus.fast_shutdown=1
      zend_optimizerplus.enable_cli=1
      zend_optimizerplus.enable_file_override=1
      apc.cache_by_default = false
    EOS
  end
end
