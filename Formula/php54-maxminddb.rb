require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Maxminddb < AbstractPhp54Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "67a1d8d2578cab9d3633066087d9e41ce8a8ce1f9877a78eb5ff2f5996e147c7" => :yosemite
    sha256 "8213845a772d57699a382cc14b1a1a749031f68380ae324b728ef8f46cba0ffa" => :mavericks
    sha256 "d261375d6a97a1de36480aece2dbdae06d6c9d599fad3c049a3d8454c56c96c7" => :mountain_lion
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
