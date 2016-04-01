require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "1ac82f0e010c69134d02a632bc3ed8316252c79dbbf018e13a4d9aee8412d346" => :el_capitan
    sha256 "259313bbf380a41d3654fd7820e4813e81205ba8adf35398613e177f70ad7327" => :yosemite
    sha256 "df5d7d80f621f35e20ec66998e5156e2661af9aff9b23298adfbacaac7ff34ce" => :mavericks
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
end




