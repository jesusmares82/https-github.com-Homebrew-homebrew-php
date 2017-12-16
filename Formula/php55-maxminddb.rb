require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Maxminddb < AbstractPhp55Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "c29c2225e9bcddc977dd7337416cbeec380d4b8f05ef23fc3b37706bdba5e01f" => :el_capitan
    sha256 "6a249d6b8f0b237380001b9f54cf7be70a679a14cfeb33d1b94e7bdeab808244" => :yosemite
    sha256 "1345548ea23baffb28aa0a204660ec73137056ce268d777319cc3d4a4391c500" => :mavericks
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
