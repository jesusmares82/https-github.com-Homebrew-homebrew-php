require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "0548445388b9fb8c14c5f6389a0ddcc5d80574f6837c3fed9e0c236daf7df103" => :sierra
    sha256 "2279ad5a96702a01e39e9cc269f75498876c425c6180ef8121f4e6a31fa05b1e" => :el_capitan
    sha256 "6e2ee2cd98e399092277ac1eb4f5f4f16a866e670f7424ddd0bfe2c170168725" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end
