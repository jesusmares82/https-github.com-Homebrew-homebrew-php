require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Maxminddb < AbstractPhp55Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "32a36bdf0267d953c8c49deecb17edae58827454fb17e62590009a9dee3c7aa4" => :yosemite
    sha256 "82902e414598365a430b54f0f32e9a471723a6a452c0a46b848a85b4f4a68239" => :mavericks
    sha256 "10165c6c182c02c4bbdfc1ca28252d7426067806b52fc4825e1e1a40898a5e28" => :mountain_lion
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
