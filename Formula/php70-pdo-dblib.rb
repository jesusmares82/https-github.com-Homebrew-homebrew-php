require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "A unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  bottle do
    revision 10
    sha256 "7f964e5b5508a0deb3bbcc48ad5400c31d6b2012ab3913a7268981a85dbb6584" => :el_capitan
    sha256 "3d115cc917e3ac871b54083b7b4780ccbed68c31bdff1ea0b9e8d6d09f111c7f" => :yosemite
    sha256 "a142ff3eaf386468a57dedf9cedf5be4672bbbf66785c00ad2329b3ab47f447d" => :mavericks
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



