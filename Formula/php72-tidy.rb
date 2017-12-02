require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 8

  bottle do
    sha256 "40464ed306de7b4370da95c21afecf86f0fdeda37db738d29f9222c51a627846" => :high_sierra
    sha256 "42ad15ae675a58dc82542b1af17dfd38dbc5aef1bab5f469a07c167fe38a8df0" => :sierra
    sha256 "1d15bd2e2f5307cfa9a60a1872837575412e7fdad9e3fafe41c52c23335d69c3" => :el_capitan
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
