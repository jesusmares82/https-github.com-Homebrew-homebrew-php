require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Igbinary < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/igbinary"
  url "http://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  depends_on 'igbinary' => :build

  bottle do
    cellar :any
    sha256 "cc00d3435e67890633b8a4cd29d43a4e0eedfbb797ef198191a1087e22b5645e" => :yosemite
    sha256 "79db736152cda26c53316d48aa1eadd302936dec017df9d9d9461a91daa7f6e9" => :mavericks
    sha256 "9b65e668b1a2a33b50c0295e790b4f7a9fda35d9e3c5794313c7bd8412cf00e8" => :mountain_lion
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    rm "apc_serializer.h"
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
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

