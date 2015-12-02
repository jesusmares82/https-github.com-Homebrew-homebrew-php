require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Igbinary < AbstractPhp53Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  depends_on "igbinary" => :build

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "a36d2c27f3edf584bd94998e8be48d0be1f997f2cf82b2e585fb01073dcadd70" => :el_capitan
    sha256 "6d2df6084eac699049bc0818b197f3fd7e799956eded4d213c34437adb504741" => :yosemite
    sha256 "4fd6dd0798db0e384d35b1682a4283838310da2820975c37af956096650df0a9" => :mavericks
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

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
