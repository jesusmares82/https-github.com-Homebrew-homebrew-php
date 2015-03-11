require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Igbinary < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/igbinary"
  url "http://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "dac0e98c45a4140e6865bdb0413b490bc71486c73be3c0b7a68b256231cf9244" => :yosemite
    sha256 "8257476f7d9627364ca143a90bade44ad620c1eef384d6d2f85db104bcda33ca" => :mavericks
    sha256 "444c50e14eecf38bb9820e7a7482ea1cc3682bdea3f6c97c0ec41fc22705a9a9" => :mountain_lion
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
