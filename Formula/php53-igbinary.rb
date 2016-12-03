require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Igbinary < AbstractPhp53Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9d81aa37971737e457f599c999f34a0f723dca65273edd4c544333d67c132363" => :sierra
    sha256 "d650f47011d73e4eaffc311fef67ab233a8ffffce692f4a9f0f540fa427933e1" => :el_capitan
    sha256 "f47d195443fed0a8360515f9d7fc23d1756975f5c70fb26db68dc78b2def62d4" => :yosemite
  end

  depends_on "igbinary" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
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
end
