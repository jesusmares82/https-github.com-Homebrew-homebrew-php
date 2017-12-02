require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70PdoDblib < AbstractPhp70Extension
  init
  desc "Unified Sybase-DB style driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_dblib"
  revision 17

  bottle do
    sha256 "dbe5e8fabeae597878a1914a2da1981b3fd93cec76d993088b9e4c11db0b98f6" => :high_sierra
    sha256 "45d957eb0144c4fd597cf2411a36a4a0d02f0ac4e7cea5bac1a08ef68c58b4ed" => :sierra
    sha256 "e8f38b3ddd49d1c9e136b831b8c1795a1bf65fcff2230f40c2497dac1db3d272" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
