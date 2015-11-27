require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 7
    sha256 "616ab44639717ea85c186e1c90030468e5577ae2540e47bec03cf3f48c2387af" => :el_capitan
    sha256 "6ee1fe4363dba1e09d36a73c276eee67bd64572fa3155f2e041ea6ec1c95c360" => :yosemite
    sha256 "02d1ca1afbf593e55993d9f3203b11ffd46b88a0ffc027a7415d72333474cb67" => :mavericks
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
