require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Igbinary < AbstractPhp54Extension
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
    sha256 "7f56a6653f954ba113c51b0466e2f5a5b8ed3ddb3596e6d09619d452ce756e4b" => :el_capitan
    sha256 "b7307e03af29c4b15bd7c692b7ef10dda38d49bf3ecda80ae52c2f2eb0d2ff7c" => :yosemite
    sha256 "3de701dc09441672dc82ea84ec9a713ef735e0cb2154592fb8c178d2e7abc132" => :mavericks
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
