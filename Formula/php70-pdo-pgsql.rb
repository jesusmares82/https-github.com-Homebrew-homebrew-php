require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 15

  bottle do
    cellar :any
    sha256 "59ede6c9b468fa702cfd058236acfe4dfb3130b1128fe0cef6731984099fb558" => :high_sierra
    sha256 "657d8fcd4ca13bb01d435a723ae7a7b53d3ff06f226c1b8c4ae7956b53194631" => :sierra
    sha256 "4d28a056b5711283ca8e290d604b0f6441d95c799345aaa3b456f42b4a02768e" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
