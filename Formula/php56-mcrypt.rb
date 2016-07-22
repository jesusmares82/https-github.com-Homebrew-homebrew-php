require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 12
    sha256 "e2e4d2de418d20f187c35077e77074384ebe123c07f0504bae205a6a52aefa11" => :el_capitan
    sha256 "bc31aeecb045646963961de1744e39cdb06ca13916af0da682b1d7dcaff4376d" => :yosemite
    sha256 "053e6b1f2edfa4c98b2335a6d0e3146eb5d379d53b70e48644b5f54e8bc516c9" => :mavericks
  end

  depends_on "mcrypt"

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








