require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "dfa7ccacf98fc621d8f5eb38e3e35bdc03b80403cfc29063a970f5d2324d148d" => :yosemite
    sha256 "f6cfbf4f3491000245196b5108d7b93720667fa2d06fcfc6eda4768dc363b530" => :mavericks
    sha256 "0c2506258e58b6f29b77ec9a370df7727c9e8669800e62abca6a178f67087f51" => :mountain_lion
  end

  depends_on "postgresql"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula['postgresql'].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end

