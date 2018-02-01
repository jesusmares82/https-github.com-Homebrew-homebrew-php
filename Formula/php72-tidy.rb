require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 10

  bottle do
    sha256 "ea2edf49daade7eb229d5c29c36be1f2a5d68c0f2b022f4a907fe91da3a95965" => :high_sierra
    sha256 "3cad7330638f84db59bac7112e14ac4bea43b0ed1a9aa1321d8c56fed4c6f2b4" => :sierra
    sha256 "0f6c3b256f6ce083fc9e439d52b0f3ba33fc025236bd761cfbf7645872db4e8f" => :el_capitan
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
