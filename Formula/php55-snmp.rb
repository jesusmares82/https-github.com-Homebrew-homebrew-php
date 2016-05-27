require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "fe14414653df486355440858f834109a0767be7a29fa99a2248034ba0251a192" => :el_capitan
    sha256 "f91eff08d691be32db72597955dc22671c71a4713b8c6158099eba258a57c345" => :yosemite
    sha256 "15743ddb659f7ef29752dbc83d5d11bef0aeea223877ce6ea0c64d875a44b2b6" => :mavericks
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






