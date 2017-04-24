require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Igbinary < AbstractPhp56Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "137d2cbe45cfb2ea60da883e18f569db9a6dcc946fe886e6798f1a221d92cfe0" => :sierra
    sha256 "0978fa13d8748c776299df70b66fb246f7ec0901f1cb7e49ff0bffefa999777b" => :el_capitan
    sha256 "069580ebbc8c3a7c279f2e743760e42cfc40e1c9ed95227125d8c171da56beb8" => :yosemite
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
