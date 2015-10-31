require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "dfeb05c6d6da7bcc61c708b802b484359f2a29319ad9cc0b41f9db454e33c940" => :el_capitan
    sha256 "9eda5c47343d6dc269a59faed9f196c68f97ca071f39b4679dd28f13e280ae64" => :yosemite
    sha256 "0a3e99fd5763de7b5362eb9ec2a216d5deeca39353c7af7976ad643ac5e69f71" => :mavericks
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

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
