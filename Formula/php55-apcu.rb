require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Apcu < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/apcu'
  url 'http://pecl.php.net/get/apcu-4.0.1.tgz'
  version '4.0.1'
  sha1 'f7569e959e7ff09c90de3636f4638be766bab5fd'
  head 'https://github.com/krakjoe/apcu.git'

  option 'with-apc-bc', "Enable APC full compatibility support"
  depends_on 'pcre'

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.include? 'with-apc-bc'

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install %w(modules/apcu.so)
    write_config_file unless build.include? "without-config-file"
  end

  def config_file
    super + <<-EOS.undent
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
