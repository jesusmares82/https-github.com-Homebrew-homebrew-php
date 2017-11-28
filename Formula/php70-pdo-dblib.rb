require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 17

  bottle do
    sha256 "92ac6ffb2fbc423d73a8c237b0ce5654d4e6c14367fcbdf3dbc2b6d296f35944" => :high_sierra
    sha256 "3693e1d53af721afdb437da8a6ec0f51f6f802a6cd4bb1de5a77413335891d34" => :sierra
    sha256 "faf40ec050bf78f3948d59570aa197b3c0e2c23857b5b699ba9698f592c461a2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
