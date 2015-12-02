require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Apcu < AbstractPhp53Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.7.tgz"
  sha256 "178a731ee3435b451f1144bc4a63c9d70d4909a2c434e17c6e07db554df90bd6"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "4b01dcf6c27be251614812e37c58367c4ca0a33edcb59d532ec23b2c2cb99a0f" => :el_capitan
    sha256 "4341db2b157581301fafeb9ddb19fdff24c834d5caf25fc7c284167d45637b9c" => :yosemite
    sha256 "70006cb4b8e04830e04084709d7f40b5f12a6c2f6744f3a3c50529f8782a04df" => :mavericks
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
