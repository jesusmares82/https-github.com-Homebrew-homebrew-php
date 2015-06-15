require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pspell < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "487ddded390bd92dd1f6805e639efd8dffc314374f69706a1214b4969708043c" => :yosemite
    sha256 "12bc6982e03fa016333f072efa752e7b9578f08f9cf09bde9b059a3275b14ac0" => :mavericks
    sha256 "5153ea98011a72b2009b457e9fbc7c0359a1727e62e1943c78337318048a8c16" => :mountain_lion
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula['aspell'].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end
