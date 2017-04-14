require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 10

  bottle do
    sha256 "3f03f4598b124c443e95191c8731a5a75ca1bcbbbc9771d3fb9b9bbb1ad43b16" => :sierra
    sha256 "f46752cf65fffdc072750271d7fc8f662338fd044dcc928da13c62b805649932" => :el_capitan
    sha256 "a55e291828b976041ebe204e43e368cd11727abdf421f9becf8a97c55cfd066d" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
