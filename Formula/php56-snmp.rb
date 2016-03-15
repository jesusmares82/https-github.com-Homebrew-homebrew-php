require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snmp < AbstractPhp56Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "8ca84d484ee0304cf7a251d20586d2a28e7032a3a19e37b65954a5b6ccf24cf0" => :el_capitan
    sha256 "ff7f70b1883037e2f62a23038ddc792a472ba659d9ae518aabd09bdb065a202c" => :yosemite
    sha256 "003eefc3577725d485bc3268373c7cf0ede8e0935abf8e57fee926f348a68d8b" => :mavericks
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



