require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "73d798d14806912cfd59e5ed4dd7d4795025616f83aefc1e7edeff3b664cd583" => :yosemite
    sha256 "ba17cf28c220adc288ba022d971417fe9155a6cfbd8e56a742685a48af5cb29c" => :mavericks
    sha256 "4c4252533abb3119a30486cb7c2f1066a3088310cf62ec3b12eca4c9a0c1ac9b" => :mountain_lion
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
