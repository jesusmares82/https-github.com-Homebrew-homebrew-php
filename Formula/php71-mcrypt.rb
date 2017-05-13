require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 12

  bottle do
    sha256 "ef00103225e3a7ad4319d401ed54989e7732bd0af98eca60087380c08ed0a136" => :sierra
    sha256 "fd7505045014e6bc43cffc77d7034a00b04c8a2290f3307f1c6f7d93830d126b" => :el_capitan
    sha256 "c9bd15a4e70d4517bad95c12f8e571dccbe76bbe077a68738ca1c1e84a0c9798" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

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
