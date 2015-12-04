require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Apcu < AbstractPhp55Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.8.tgz"
  sha256 "bef4f5ae309526a332e0f6b98f0579a45d6000b928991babe684d4c22432d57d"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "75e8740ce93a36e7390ddd65d58d7dc8606f62b51b3410178bc6268004877ca3" => :el_capitan
    sha256 "7ba7c05b697cb76c6dbdd982e7c008d2e3cd220ef06d16d174e7eebee9561098" => :yosemite
    sha256 "2bf62225210fcf5e4f5489fbb024bb29863011c689f9957642d581f00bc11c26" => :mavericks
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
