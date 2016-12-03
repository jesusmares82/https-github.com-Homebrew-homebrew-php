require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Apcu < AbstractPhp71Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.7.tar.gz"
  sha256 "f94001a9da186c115d76f88de6f2504fcd84f83c234ee4f677bc4c7200206f46"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f4bcffcb95f699f3c7735fd82eb972178de14c019c1a22fef8b636f88ca0aa60" => :sierra
    sha256 "b7ff7da25df668888ccf2e1684e81a1f0537d51be94d97671db10efc1d524e24" => :el_capitan
    sha256 "650fcc8585cdc09581265c2d2e85bd2f90c6b6432cf916af46058f5ca89b05bb" => :yosemite
  end

  depends_on "pcre"

  def install
    ENV.universal_binary if build.universal?

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
