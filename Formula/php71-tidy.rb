require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  bottle do
    sha256 "6923cd6acb17ffa2f36fac1f962a594dd0535d5efc46957887ffb8d5125dc181" => :sierra
    sha256 "b91e3260533a207a95fa75e6929cd8661212f015c5e3d0c1cafdd451ff81cf24" => :el_capitan
    sha256 "2d55e8075d7a7fecba7693b8f2f36b893fa2e8db514d7ed29e0c210d3d569110" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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
