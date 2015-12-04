require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Apcu < AbstractPhp56Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.8.tgz"
  sha256 "bef4f5ae309526a332e0f6b98f0579a45d6000b928991babe684d4c22432d57d"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e334931b7e592afd0d0a5fd864386a9cb403f0905d50e0f5853799bd26925e3e" => :el_capitan
    sha256 "f8b2a938a0e4d7bc8419dd71394fd5c1ccd9b7c45cb5433994c9efa695552133" => :yosemite
    sha256 "65461ab78eb1e49fa6a086ee0414fbdaa61001802da4b197c83425d3ea01bd8d" => :mavericks
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
