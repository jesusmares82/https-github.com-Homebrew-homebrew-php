require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "fd51eb05b1a0a3fa0e6ff4bc4dbfb4d727ce20353ce5f5626068c3744fb1a2c5" => :yosemite
    sha256 "c6b61ddcf218c4f8cccfc17c3d0b9309174d91bbd71b1a5c032e4213804ffc54" => :mavericks
    sha256 "3dd5122162b62661d052f7577bed323bdd327003e352cc13b1b06101104700fb" => :mountain_lion
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("gmp")
  end
end
