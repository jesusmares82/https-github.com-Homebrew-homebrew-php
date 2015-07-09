require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "70dadf26501b4ea14443b936bcd69a0cda0a9163dd46c1dba48540cc39793cb3" => :yosemite
    sha256 "9154e6b0e9bbefa35c0142c9790d989a96582705f8cc613f17f8f9b0d1a38874" => :mavericks
    sha256 "e57b2a238854b1b8a91085c3d1cf3d8d4b412c7de5df00cf3f0c3d2171518be4" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("tidy")
  end
end
