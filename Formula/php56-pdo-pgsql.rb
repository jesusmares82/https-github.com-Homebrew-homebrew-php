require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoPgsql < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "d6c76c7064abf8c9a698bdaecc1356ce46253b9152fd560bb3c193124dc3b526" => :yosemite
    sha256 "f20f843bab83533fb11a8a9a33aec4cbee23b3f91f3bfe7c2dd6484a70ab1aee" => :mavericks
    sha256 "f07cd45451816fb455fd9cb631411cafc4739c1fac545a3d75df6cb510a77a77" => :mountain_lion
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
