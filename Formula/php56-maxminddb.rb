require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Maxminddb < AbstractPhp56Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "f7b8fdeca44756fc0b6c2cce9068d6a5a8c576862e78dbec9ccb7fd13b087aae" => :yosemite
    sha256 "9abd1be80a6799bd54459b60f9b0b13c9f7023614eea7464fc602d7df1018173" => :mavericks
    sha256 "d6cc67a28d556572409f888d10fb99aec3e6eb76888a811d593de30f05547e61" => :mountain_lion
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
