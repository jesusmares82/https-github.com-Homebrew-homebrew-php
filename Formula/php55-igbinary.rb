require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c0fddf4ac66e374d7967be36c534c6af34820e2c2821a49a02b3de764d4daa3e" => :sierra
    sha256 "b0e3112f4c039f6d3d2b2b445517dfc5e85e16d555ba9622e852c6cac8ef935b" => :el_capitan
    sha256 "3e88e99f8c8b643b755a30628e8c852392c4267d52400552c331d6338fe4bb20" => :yosemite
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
