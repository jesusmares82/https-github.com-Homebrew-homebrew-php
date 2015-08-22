require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "3132e0ea93bf083590816881f781da2779ca355ad676b2f24a57b9dce8ca2c8a" => :yosemite
    sha256 "6d9e50da2f9ab3be61c1b76846132d96ad18ba2df8ef96699c46800a978d835e" => :mavericks
    sha256 "c11340a406482f0813d5dad13e1fdbfe841973b52e90a6ad26f43bcb7462b5a6" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pdo_pgsql")
  end
end

