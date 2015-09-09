require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    revision 1
    sha256 "d05f8f28ea2d0cbb3ab49ed17a1a6e75f5ab07c7c5f6328dde5ff2781b5f31fc" => :yosemite
    sha256 "93100f69b2b460f51de8de4da29fd2a1d422f156ed7895832d71f0ff0c76f2b5" => :mavericks
    sha256 "7dccc96eb123e3718af864ccf4640d3b092a04782e08a9bb10a687986d95b194" => :mountain_lion
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

