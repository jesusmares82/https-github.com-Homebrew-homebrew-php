require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 5

  bottle do
    sha256 "da7bf60f20ea6f5356e533f439d244238434e4f01b6336512219759ca703f844" => :high_sierra
    sha256 "b236e5410956fe1774f60455edcd56b0b7dc8264ce44fc2956400125afab61d6" => :sierra
    sha256 "88df517028ecbea29aec59423a8929b5f2b8f581026b649de55539d334d2ce95" => :el_capitan
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
