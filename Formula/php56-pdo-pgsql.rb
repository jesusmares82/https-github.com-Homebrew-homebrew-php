require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 7
    sha256 "e240ca1436647ebc9554928e6d268929dcefd2c1dba2389d0836bbf9e427b823" => :el_capitan
    sha256 "a8ac93a8c34c1ff24123d8d0c60aded897b98dd2a6a21595aa5daa50dbab9d75" => :yosemite
    sha256 "ef30fe00ec8ef63ffa9f51e96f5df6a6f6fb9b8635d054aa9170b46850361ef9" => :mavericks
  end

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end



