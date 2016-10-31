require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Igbinary < AbstractPhp70Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

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
