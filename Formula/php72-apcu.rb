require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9aa9f12739879ee37f928d25cf8757296e1c2e917522b9e63ce6314b103155ad" => :sierra
    sha256 "c8686704afdad205fca68491951fc86bb079cd8ea4071794d6a9d899e7ef43e7" => :el_capitan
    sha256 "d2cbe7a10b7b39ec7f20483d1218ba3a2bfe06cda9c94268387442cfb658e152" => :yosemite
  end

  depends_on "pcre"

  def install
    args = []
    args << "--enable-apcu"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    # Keep all the headers that are needed to build php-apc-bc
    include.install [
      "php_apc.h",
      "apc.h",
      "apc_globals.h",
      "apc_cache.h",
      "apc_stack.h",
      "apc_lock.h",
      "apc_pool.h",
      "apc_cache_api.h",
      "apc_lock_api.h",
      "apc_sma.h",
      "apc_pool_api.h",
      "apc_sma_api.h",
      "apc_arginfo.h",
      "apc_iterator.h",
    ]
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
