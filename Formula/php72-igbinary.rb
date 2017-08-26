require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Igbinary < AbstractPhp72Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
  head "https://github.com/igbinary/igbinary.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "7e41d13f6e676be4f55606b2f96436d6bb849de3cfbd86ce39634ce2b74dcb64" => :sierra
    sha256 "fc086ec5a620454407c594e5bf5388d63bae20f90d10e8e567b7cda345370bb2" => :el_capitan
    sha256 "8ad1ba2a9d2d2a81a4e53b49fd879250e072a54655dd5887246df6f0180eb1d2" => :yosemite
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
