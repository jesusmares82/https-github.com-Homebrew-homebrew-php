require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoPgsql < AbstractPhp70Extension
  init
  desc "A unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  bottle do
    cellar :any
    revision 12
    sha256 "b4c38de9947792050a91681f18982127fbd47cbe531ae7af7c687641f50a9bae" => :el_capitan
    sha256 "1e9c58a36d96c8a6c3ea15129e9bcb1724154b2d510d3e8317a6fe94d743ad56" => :yosemite
    sha256 "0ad00b13b7de2ba50505b379682ad17c53e6bafa55b43c037bb4faa46fbf71ca" => :mavericks
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




