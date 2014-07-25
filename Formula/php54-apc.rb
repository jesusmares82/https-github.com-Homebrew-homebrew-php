require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apc < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/apc'
  url 'http://pecl.php.net/get/APC-3.1.13.tgz'
  sha1 'cafd6ba92ac1c9f500a6c1e300bbe8819daddfae'
  head 'https://svn.php.net/repository/pecl/apc/trunk/'

  depends_on 'pcre'

  def install
    Dir.chdir "APC-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-apc-pthreadmutex"
    system "make"
    prefix.install %w(modules/apc.so apc.php)
    write_config_file if build.with? "config-file"
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
