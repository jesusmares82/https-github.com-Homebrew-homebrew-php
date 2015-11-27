require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 7
    sha256 "9c1e11bfdf22d6c48d74a4ad4fee35c9820e123fe57e1c46f70c981ebfc5d24c" => :el_capitan
    sha256 "705fa07f430788eeb7280eb48b44b6a56c1172b7079f8fc92209ef0c37df0deb" => :yosemite
    sha256 "e69c28dac234f0e416efb1cd97366142963b3b4c54dbe07a57c805c275715fe8" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
