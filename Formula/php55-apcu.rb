require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Apcu < AbstractPhp55Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.7.tgz"
  sha256 "178a731ee3435b451f1144bc4a63c9d70d4909a2c434e17c6e07db554df90bd6"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "982ce5b8b5168cb4b5df9227d2621d6ce7d4bce297541300fae6be31c90f9123" => :el_capitan
    sha256 "9d97f0786619fe0fe1cb05335c3fe398dec2a8bb278945a07f19439ab44b2d0f" => :yosemite
    sha256 "b19a9ff8e9bf307df07e9f71490e6b7f666ab4e907a6b15648da2f7a7e422ca2" => :mavericks
  end

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
