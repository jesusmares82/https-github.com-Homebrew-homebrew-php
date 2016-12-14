require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Igbinary < AbstractPhp71Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f4f28ded4c9c9d5da76a6fd5fc31c72644bacf403acf58b1ac655a32b3e75670" => :sierra
    sha256 "f287afa211862c3ca24c055f2ff6821b5633ec538891eee9f85fbfbea2149f1c" => :el_capitan
    sha256 "c82492bb40f065583d297ec9ec09452f7f0bcc6f6aa960a61d124e391948f2c1" => :yosemite
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
