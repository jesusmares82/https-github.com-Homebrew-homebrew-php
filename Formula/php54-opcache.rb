require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Opcache < AbstractPhp54Extension
  homepage 'https://github.com/zend-dev/ZendOptimizerPlus'
  url 'https://github.com/zend-dev/ZendOptimizerPlus/archive/v7.0.1.tar.gz'
  sha1 '61fcbf613ec31deed1470d88107e8d462036a720'

  depends_on 'pcre'
  depends_on 'autoconf'

  def extension_type; "zend_extension"; end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make", "install"
    write_config_file unless build.include? "without-config-file"
  end
  
  def module_path; "#{(Formula.factory php_formula).lib}/php/extensions/no-debug-non-zts-20100525/opcache.so"; end

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
