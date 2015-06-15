require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55PdoPgsql < AbstractPhp55Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "9ccede6608a7fa5478c980d1c1219109e37d11898c539ea3bbd9f05a40d11b63" => :yosemite
    sha256 "5aa4fc228e6bd42082771b128abf515502d140d2e4d6c30f00f8e725e2b32df0" => :mavericks
    sha256 "5019c70c700160c72609c0c01dc82a2081b3f33c68ea4fb8f4303df37cd53283" => :mountain_lion
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
