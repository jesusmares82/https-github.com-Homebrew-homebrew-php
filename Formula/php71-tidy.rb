require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 5

  bottle do
    sha256 "e021e4bcd49690d16c57489c52cd0b9026aa744033f883e998b4657b8b3ebedd" => :sierra
    sha256 "5a1e4bb49b4a4895b4e5cf342ae757fcea78b251f559da852ea24814e5a86221" => :el_capitan
    sha256 "ed97b6738e2c5c618400696bc79daa6d4678813b6bda85c509885ddcc09decf5" => :yosemite
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
