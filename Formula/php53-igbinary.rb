require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Igbinary < AbstractPhp53Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c83a1518cc996c40119e7b3868c572c5ff62d25e5bd80500bf1183ec19aa2d4c" => :sierra
    sha256 "cf83a32379791a36e6c7bdc31d678ce2ec6a73596a1d14cd56d3c2210027e93e" => :el_capitan
    sha256 "411f4900c4d4259d7538514a120f834b1a32eb9b74f1f7ebdd2df9d90a7b6610" => :yosemite
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
