require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Igbinary < AbstractPhp70Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.3.tar.gz"
  sha256 "af1f19dbf64e37311099e444f2121b917349cc104abc858e34b094d1a296e179"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c6f24492a7b4c515537cac5352f1de5f160f1b55dc36ce9beefff329e05d112" => :sierra
    sha256 "79daed1d436e1dfb442fa628e7e2c064f40f8fc7effa64b313740afb43bc8819" => :el_capitan
    sha256 "58c027255d32eb3a128343e245fd572d87e5176c0e0180afaeafc46bca98207e" => :yosemite
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
