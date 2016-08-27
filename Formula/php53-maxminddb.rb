require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Maxminddb < AbstractPhp53Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "f0c7651189fb6495e0c6d6ade0fee390132ca2fb0575d7be8298cb439892353c" => :yosemite
    sha256 "155ae1f36de687ad703a50a9655c292441ab712f9efb8b731f284af76ac426e4" => :mavericks
    sha256 "231479a8b60fd751c26c6e23925f818741196890eab695225f3ae905bf178b22" => :mountain_lion
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "ext"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-maxminddb=#{Formula["libmaxminddb"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/maxminddb.so"
    write_config_file if build.with? "config-file"
  end
end
