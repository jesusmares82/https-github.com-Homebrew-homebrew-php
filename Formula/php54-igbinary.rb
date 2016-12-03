require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Igbinary < AbstractPhp54Extension
  init
  desc "Drop in replacement for the standard php serializer"
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9309877a05a53b487993a295b707468dd0263a902fc0a3a4b00bbc46de6b88f7" => :sierra
    sha256 "01b26e9ddc5a7368bc04efaeb4659fe887e26370a7420911f7fb08a022db08a1" => :el_capitan
    sha256 "55b5df5bc52e5a491b8dfe9f279066927bcaaf503d043326b0250c84a2cab9c8" => :yosemite
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
