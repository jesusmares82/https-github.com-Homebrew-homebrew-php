require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "4fba65858958fbcc3a9eb52bee0a2b7eb9018a8e47f213d03df6d2d4af85cea9" => :yosemite
    sha256 "9b9f247120f78121f278325b5deff6593d6c36ebc381dbdf0c15c697117d9cc6" => :mavericks
    sha256 "a6fc9305d09fdcb1e61066ebdf71e49d2a857cbe788f0e5b17eb55724dec1041" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end

