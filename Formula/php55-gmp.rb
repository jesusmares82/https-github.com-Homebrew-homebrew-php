require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "f75ee2230a90478ab9e8ad095b637826b7905d2fef2b074c2c5b5ce9033d86ba" => :el_capitan
    sha256 "b766527eec08a03fab7a4140dd6fa218383d61ae02b113b15eeeff71354200f5" => :yosemite
    sha256 "7bf5cd6852af4576640b1aefd72a9f7812eeb356312907a5cd490aae8be6dc3e" => :mavericks
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




