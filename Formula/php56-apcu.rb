require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Apcu < AbstractPhp56Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.7.tgz"
  sha256 "178a731ee3435b451f1144bc4a63c9d70d4909a2c434e17c6e07db554df90bd6"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "50a8dc2e5091fefe3b4c3f9d8305badddbf0c765fed8b42f50ed1e5896f093ea" => :el_capitan
    sha256 "78fbe8dca0d4febdcc76822a82ea08829ef8d230ad5c12b5bd1f54f7fda0a78f" => :yosemite
    sha256 "c4440bde2d4c7b26d56a13fe01b88a9cf801cac561c0cd8f0fa6d5e84c9ca6b7" => :mavericks
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
