require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Maxminddb < AbstractPhp54Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "84503c294d993a4fd9c72d9685bf40e6e45e7994f2ecf6c6649059bb0d9c6f7c" => :el_capitan
    sha256 "adcca18df7fde6af5d0667ff55335932d038a3326700f183f26166cb4030413b" => :yosemite
    sha256 "4818cb0d44b7768534b9c2ef09340c69b47d0c52306cc813aa4c555efab2a651" => :mavericks
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
