require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 6
    sha256 "f8716a43b93b1cdae38d392eefb6ec2e21479c12c7a6ac75bd56e569d184aed1" => :el_capitan
    sha256 "25360a71b2268ae75eb9b449d9c5c80442a17685be6fff08cf9077327123ea55" => :yosemite
    sha256 "67d6fd25163ce171d961d187d055d0265e71ddbc529a00416343fd45c6f32fbb" => :mavericks
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
