require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 6

  bottle do
    sha256 "a1bc812fc5331a605ae3ae2536f949515a80aa03af0d4c21be8c315089a87dd5" => :high_sierra
    sha256 "9921249f169faee0faecea6b0fce4d629e38289ea8105c79c6c3c4b3b24ed6e6" => :sierra
    sha256 "a2ee01c7b079e8bbd1b286aca6f0cb38cf6b685696adf1ed2dd823e461cce20d" => :el_capitan
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
