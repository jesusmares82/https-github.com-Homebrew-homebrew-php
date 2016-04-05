require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msgpack < AbstractPhp70Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.1.tgz"
  sha256 "d32aeef9af3be6135a06f29e28ec9f386cde9d90ad346a396d9ba8018a7044c6"
  head "https://github.com/msgpack/msgpack-php.git"

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
