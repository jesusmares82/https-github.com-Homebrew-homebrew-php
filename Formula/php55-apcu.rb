require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Apcu < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/apcu'
  url 'http://pecl.php.net/get/apcu-4.0.0.tgz'
  version '4.0.0'
  sha1 'acb373b28cffefad6c19634ee0d504f209c23808'

  depends_on 'pcre'

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--enable-apc",
                          phpconfig
    system "make"
    prefix.install %w(modules/apcu.so)
    write_config_file unless build.include? "without-config-file"
  end

  def config_file
    super + <<-EOS.undent
      apc.enabled=1
      apc.shm_segments=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.user_ttl=7200
      apc.num_files_hint=1024
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=0
    EOS
  end
end
