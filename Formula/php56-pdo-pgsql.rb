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
    revision 3
    sha256 "e3e93e442e014047ff7e286f11f9ead3d4b99eaecfaa79f5c16a4e906affc38c" => :el_capitan
    sha256 "a409526562b6ec01c5fd8765a3796bf84cd3c4196fed31853acd06fa39be5063" => :yosemite
    sha256 "d4a6d7407f34d03d9413f99735369a4fdc294a63d2718718fdebde4c3089d684" => :mavericks
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
