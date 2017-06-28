require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Maxminddb < AbstractPhp72Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "f3158bfdef093d54cb85148a42b7f39c17c54f6cae329bf772182a45921f6e87" => :sierra
    sha256 "ef4de086617ad67580fe91053959a1bf2f6a6311662d386c690d2349c1403f0f" => :el_capitan
    sha256 "99e9b9f106218c78dc928e5609b2f0e1be8550f969271e19ce0af75322032c36" => :yosemite
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "ext"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-maxminddb=#{Formula["libmaxminddb"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/maxminddb.so"
    write_config_file if build.with? "config-file"
  end
end
