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
    cellar :any
    sha256 "371c4419efb28a57278acc08922ad380adf21d1b4a4faa646750427a08fdb1a1" => :yosemite
    sha256 "a3c01b3454675bdd419b437ac8e5821b626713ba4fc8c4b9d7bbaede5f2ad074" => :mavericks
    sha256 "8f16e032a7e9287b76818fee9c319ca4fc792c2ff624115e37d2c26f7de12552" => :mountain_lion
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
