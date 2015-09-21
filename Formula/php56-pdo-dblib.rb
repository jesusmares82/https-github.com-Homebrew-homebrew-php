require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56PdoDblib < AbstractPhp56Extension
  init
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "15653df3d900a59b4d6c47c9ef4bba8de4bb7478890f4c5f3c6b48a52bbfb2d1" => :yosemite
    sha256 "dd136efbd0f18b81988366f55d2beb715c61ac13ea6500a73f923d42030c31a5" => :mavericks
    sha256 "c7a82ef7b1ae704fc9c124063b8f5864331f7b2d6fad7a184410054c8341d7e1" => :mountain_lion
  end

  depends_on "freetds"

  def extension
    "pdo_dblib"
  end

  def install
    Dir.chdir "ext/pdo_dblib" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
