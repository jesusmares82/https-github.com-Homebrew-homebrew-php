require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  homepage "http://pecl.php.net/package/igbinary"
  url "http://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f068ef329ce88e3b31621155591d709ca690d6a2d11145be5f89605967cd41cc" => :yosemite
    sha256 "78d7883a3ebc6fee1fe1edfd83766b49ae28ce709c4909f32f221157dc876410" => :mavericks
    sha256 "8b16ecf378a0305fd9ec6a0729b0b329242560035497ae5135c81e8376c0f00a" => :mountain_lion
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    rm "apc_serializer.h"
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[hash.h igbinary.h php_igbinary.h]
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end

  test do
    shell_output("php -m").include?("igbinary")
  end
end
