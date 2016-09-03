require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  bottle do
    sha256 "a45e9534d94abe3a4ac81ce89ad489df31bc7e084b72fee4305a5dc60e634dcf" => :el_capitan
    sha256 "433d27736c087f58bb827afea9d0a26dfa76a03149984ed3416fc807cf465100" => :yosemite
    sha256 "00a5cd3f978daf5d9f5c0a9ca1ccbe3062797347f445b3c37949af0174d7fdb3" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
