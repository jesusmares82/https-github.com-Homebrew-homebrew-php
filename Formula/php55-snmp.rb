require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snmp < AbstractPhp55Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "8171ea6eb8b4b0f9137f582fcd91b6373688ae2c0acd3a2b82e337f769d39a6d" => :el_capitan
    sha256 "7622ab7ecd8a5a31872b2157462d9009b455413940fbc7443f94a7bb406cee76" => :yosemite
    sha256 "b84131cc2b04a73a75034fe2b56fe14f24eebc879916281e1b7316ddfeaca1cd" => :mavericks
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

