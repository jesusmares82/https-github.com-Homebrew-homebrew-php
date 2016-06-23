require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 14
    sha256 "b60eb5c792b478b77f8b4f66bce103d6fb9e542b0f2acdcecd250758cff30689" => :el_capitan
    sha256 "dbbcdf5d2b38c9f406a6e40a3c10d884cf5edd26007299a0289bd99f073d7e43" => :yosemite
    sha256 "8e5dc49e9db00b89334a057da7052339c3851858419f84c5ef1f5ddde8503d9b" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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








