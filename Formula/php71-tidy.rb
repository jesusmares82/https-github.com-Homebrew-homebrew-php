require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 16

  bottle do
    sha256 "c82f74371993fa6fd5cc1c0616d3f8d86cebec9ba96142c9a9ad1043839193f3" => :high_sierra
    sha256 "b73b5e47fd93a9460c85dc5cf36672b9c3adb25a48bdc8492a6fd089bb52075c" => :sierra
    sha256 "92a1061e010cb8ae8dc9819e9a3874911a281afac8b892106963605875a8b96a" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

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
