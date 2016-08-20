require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "8be2947c12f479880e8987d38bafb83a333c324908e6c96b4f38fd32baa6fd61" => :el_capitan
    sha256 "20aa8e3fbc8123a36bff3f3d6863e583985d509f2bc2bedead60d8b4649ae204" => :yosemite
    sha256 "aa2a4df543b40e38e462f628adb06dc10b8f1d6496f5dcfb30244c05766e249d" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

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
