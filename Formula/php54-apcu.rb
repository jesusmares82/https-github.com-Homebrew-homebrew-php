require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apcu < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.7.tgz"
  sha1 "84d68cbafea61df1ff864c7a3e8d2302a2879347"
  head "https://github.com/krakjoe/apcu.git"

  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre"

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.with? "apc-bc"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
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
