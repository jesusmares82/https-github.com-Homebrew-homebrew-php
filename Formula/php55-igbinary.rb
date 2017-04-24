require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "79ad76b2ab7f3768b445c7157b59c0059b1b021c8569e047f67113148cfe4aa7" => :sierra
    sha256 "38ca3b5ff97659157309fb11c5e57ee4bfe77a7b1289e1d0c6a1763a8fdcb778" => :el_capitan
    sha256 "9805adb4660283e72e004becb065e85657aeebe90f30aae3ae2433461a0cca55" => :yosemite
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
