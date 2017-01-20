require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoPgsql < AbstractPhp71Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 8

  bottle do
    cellar :any
    sha256 "fed034add19233bb4faae6cc226645810ce3fd0f6d5998cac120a9803c60e9c0" => :sierra
    sha256 "333ed5bd9c2f61af3dcc75d7b97d91d4ba89d069627ed64a934108d329379188" => :el_capitan
    sha256 "509f393804f7701f61edb6873b0dea879a8d5457717f866143f9de8f77e0104c" => :yosemite
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

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
