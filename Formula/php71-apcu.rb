require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Apcu < AbstractPhp71Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.5.tar.gz"
  sha256 "52a3d5d9111f1417ebc8c386df6834aec62ee5ba0f7f460866cb9459e3d25579"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "29048bb21cb9b4caaa1e2d7f3106b9540bbaf4bd9167c73ad52734b0ea0cff38" => :el_capitan
    sha256 "3200e9081ed76aea4faa65329a370aee1bba9668f5aadf5977e05165a994e526" => :yosemite
    sha256 "e0fd16a8d280e891347ff5bd2c8725f65d7238dccabc7e3a962a94d6b2174cdc" => :mavericks
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
