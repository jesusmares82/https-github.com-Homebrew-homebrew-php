require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  bottle do
    sha256 "d77a1a818f0e1a573079d79972dd05f4ebfa08441011555672fad48c156df607" => :el_capitan
    sha256 "f2b0dcb6ca7761f11ccdbf8c6f0ad89d73fd2e0e43aabad4226d37c52d14db0f" => :yosemite
    sha256 "d93b988da233012738f98ead9cdc46f4cfcb6e8ffd42671e434faeac212085ea" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

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
