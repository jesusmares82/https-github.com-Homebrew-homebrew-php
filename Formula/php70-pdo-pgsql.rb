require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "4f31473f7565185b0a8c5bf21334733c85a65781c844dac9a9beca4e392512da" => :yosemite
    sha256 "43dcd4b93026f888c70d7d6ad0d9e7f1cfc1dc01c4bc8f883c64c60c15d8212a" => :mavericks
    sha256 "21e3fcd52c40fdca04f462baa2c803b521742f238919e8ddf44716650132ac35" => :mountain_lion
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
