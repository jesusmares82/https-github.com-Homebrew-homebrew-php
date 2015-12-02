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
    sha256 "b504ec479b6cd2edddb6c46d907e149549b1d70a409aaddb40c0c3f02f7eab45" => :el_capitan
    sha256 "1cba2e335581705bbd3fb3cef73a090062be14b5984a5cc9ea69e06517957d1d" => :yosemite
    sha256 "8ab477eef124c67b89427697cd343dddfd836a0c6b3add5104ff0e79b1de0b7e" => :mavericks
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
