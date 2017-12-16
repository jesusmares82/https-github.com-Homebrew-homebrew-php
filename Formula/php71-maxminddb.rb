require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Maxminddb < AbstractPhp71Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "30941e28656748c87b9efa28f0772efbe9c18321644e9c00ad549f3bc9342164" => :el_capitan
    sha256 "42d67b9e3153058bf029e6bec119a4e891cf0380170c9e6232e4c1b37e9fed15" => :yosemite
    sha256 "e7ed3dd6e1ee72b32588f8fe3860c6880dc4c93feabb88e9de28c27115916ecc" => :mavericks
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
