require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Maxminddb < AbstractPhp70Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "59363acec4978eb1fdcc70570fe2e90bc74df573b42296f138938a31e0ceb01b" => :el_capitan
    sha256 "ecd39a8ee53593a06d9a20425a77614a02c18bf3b5ac6c16aa5bd4a628a227a9" => :yosemite
    sha256 "58d374b39b1041109b836d0a96a782eef6335b4b102d7cc67fc1ee7b21ed2be1" => :mavericks
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
