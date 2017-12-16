require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Maxminddb < AbstractPhp56Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "15a07870b3ce1fdef6d40f4516792897be083e2501f18fd155427639d860f87d" => :el_capitan
    sha256 "a9b9b323bd4054f09db3e375dd6523b352b99c614099ab25bf0e4250c96ef2a4" => :yosemite
    sha256 "3e67ff01446dc990bbf64ab6f26afd3f8686f12a3d81e5213d39f4ad89978213" => :mavericks
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
