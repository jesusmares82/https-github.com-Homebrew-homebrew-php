require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 4

  bottle do
    sha256 "8507d50f727e99a0389738873043a13fb0a2241f3430936f02652d3dd2c785a2" => :high_sierra
    sha256 "f23cf54eeac28295d2d4b73bcff2d5f3c9f112cbe3acdab7a9711c1b1be951ab" => :sierra
    sha256 "0bc1ebe82ef67cdf4d3e844d2325c37fe19ed569c9d237c6fc9babe73d61bac5" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
