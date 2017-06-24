require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71PdoDblib < AbstractPhp71Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 13

  bottle do
    sha256 "0e34f45b601a7eff1537509e3343ca1da2dba2a62bed62faf71a8759e765513f" => :sierra
    sha256 "8fe76043d50d93b871ea8ce486d997f63d6cf1ac900ee6cc55949ed92154fac4" => :el_capitan
    sha256 "76a1e1be73f24b4af90a79b812052e813b445055100b3e8ec6751fa0732e29ec" => :yosemite
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

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_dblib.so"
    write_config_file if build.with? "config-file"
  end
end
