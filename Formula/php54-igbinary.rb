require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Igbinary < AbstractPhp54Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e23b30f358f200c8bd0032178e9e7870ee6563a532661f146b6e9481a2fa976c" => :sierra
    sha256 "b3a522d5d3be30daefabb3cec589e7947d4e90b2b95a69eb0b6a860d3f94bff6" => :el_capitan
    sha256 "0c51369551318bc88f1cee996aa67cf77f7f270b22c99943c221895af8a7b6b8" => :yosemite
  end

  depends_on "igbinary" => :build

  def install
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
