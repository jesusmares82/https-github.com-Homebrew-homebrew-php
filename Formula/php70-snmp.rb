require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Snmp < AbstractPhp70Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    revision 16
    sha256 "8bd6bdfa480779d2b6aa8e97fbddc0b6d09e8effe1a70f7128afaa7bab61a958" => :el_capitan
    sha256 "7c5ea6f90b7847bf5de1e3aafae3de1a44da0381b46aa53d0552eec96eeb5e63" => :yosemite
    sha256 "6c8a5bc727b4bf013b257d26bcd0f78221eb0d0f29f400d820608be36ad2df69" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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









