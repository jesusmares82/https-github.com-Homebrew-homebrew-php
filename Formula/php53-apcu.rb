require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Apcu < AbstractPhp53Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.8.tgz"
  sha256 "bef4f5ae309526a332e0f6b98f0579a45d6000b928991babe684d4c22432d57d"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4f34be05720c4a25566986ebfbec826f72e82acd027d1500b84142b88f2286d4" => :el_capitan
    sha256 "e01e826acda9ff77008a9a0375cefd7427f9162098fdfc96f0c8e8204f681f77" => :yosemite
    sha256 "0572c7786c21ac9e5de1e4a25bc802a565fab2eda2194ce31c17b43c35609819" => :mavericks
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
