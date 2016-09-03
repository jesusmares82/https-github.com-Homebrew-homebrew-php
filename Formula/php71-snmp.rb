require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Snmp < AbstractPhp71Extension
  init
  desc "SNMP core php extension"
  homepage "http://php.net/manual/en/book.snmp.php"
  bottle do
    sha256 "548e0aaf130a1b22c2909c2ddf6f0f1dc54efe3634c17d46cf21cbf691b22af2" => :el_capitan
    sha256 "8dcb630f9249e69af4f2e0dcb521c42658b86bc4be4d078622df64be41b0289d" => :yosemite
    sha256 "f8c1e2151c42a81e85edfb932210a4d4f380241a4347cff9edbe6a4bac1cbda0" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
