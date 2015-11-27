require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 4
    sha256 "c3be73ef7a73873961e2353bcc0e1ccff8959fb60fa0ddebe52bbc3f4e807052" => :el_capitan
    sha256 "693c22055d6280dac7bc024a3cd435fd59077ef90697efc3c15a2d9beae41a34" => :yosemite
    sha256 "1848a06b3349b1dedc528a2928cb918a1c4afea5bf3e5376d64afcc7bb622c67" => :mavericks
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
end
