require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  depends_on 'igbinary' => :build

  bottle do
    cellar :any
    sha256 "2b989ed6c4df57d683e7d2f8f9773072961e212da579fd961871a9a1d73219e0" => :yosemite
    sha256 "6eb580852234291f131bfd009172be456fdc9dfd322b83dedf4fa612d9a70a34" => :mavericks
    sha256 "8e8f145596394bf33324c1cd50601cb76f2fdf4bf74608e22a07d987f7c4a422" => :mountain_lion
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    rm "apc_serializer.h"
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

  test do
    shell_output("php -m").include?("igbinary")
  end
end

