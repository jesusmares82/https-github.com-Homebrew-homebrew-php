require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msgpack < AbstractPhp70Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  head "https://github.com/msgpack/msgpack-php.git", :branch => "php7"

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
