require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "35fc13b4ba6d82d1d13948f33585abca752fa67fc0727ac8465b0bf6aada9565" => :el_capitan
    sha256 "f974a08b6200a91e36a8e1d46ee4007cf35c5665dcb02e7e020f564f5c3a065e" => :yosemite
    sha256 "ed386a4c6f6710f81f6cf2fc8491c9ec2a5b84935419579bd5d5240feef96ba2" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  depends_on "mcrypt"
  depends_on "libtool" => :build

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
