require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Igbinary < AbstractPhp71Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.3.tar.gz"
  sha256 "af1f19dbf64e37311099e444f2121b917349cc104abc858e34b094d1a296e179"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6d842376b946acfec2296ed54677c6c8f19fc775491cf0da81ba372fbe76fbe5" => :sierra
    sha256 "b5401be9daee7652af397c93ff382e2326fe9c286b50504c37a7f5eebbb51151" => :el_capitan
    sha256 "25db335a57e85fe6a0e073ef0f0878547f40a51c1cb21e13e46ba1fed9b7da8c" => :yosemite
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
