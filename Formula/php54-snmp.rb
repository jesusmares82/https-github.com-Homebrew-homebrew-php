require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Snmp < AbstractPhp54Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "c9d16c9d187cd849c5da3dc51586d4d3ec3341f0bd7d8ed9c0fec5488d323267" => :yosemite
    sha256 "226047149511a7fa54a7a9624b33890d9c7e2b691fc8d0e28ba1f4539e2da02c" => :mavericks
    sha256 "117e4d0065ab703e286f3e63939b5068aa3c147e46cfcfbb037149080f1e67ff" => :mountain_lion
  end

  depends_on "net-snmp"

  def install
    Dir.chdir "ext/snmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-snmp=#{Formula["net-snmp"].opt_prefix}"
    system "make"
    prefix.install "modules/snmp.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("snmp")
  end
end
