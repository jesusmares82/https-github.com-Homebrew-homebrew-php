require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.3.tar.gz"
  sha256 "af1f19dbf64e37311099e444f2121b917349cc104abc858e34b094d1a296e179"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "79ad76b2ab7f3768b445c7157b59c0059b1b021c8569e047f67113148cfe4aa7" => :sierra
    sha256 "38ca3b5ff97659157309fb11c5e57ee4bfe77a7b1289e1d0c6a1763a8fdcb778" => :el_capitan
    sha256 "9805adb4660283e72e004becb065e85657aeebe90f30aae3ae2433461a0cca55" => :yosemite
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
