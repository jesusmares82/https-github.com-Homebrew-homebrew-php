require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    sha256 "c3cb8e65e2268a1f264824d5ee3e48673a98f33f103b95c2ba27bb5bc0823eef" => :sierra
    sha256 "a9003fe44efff6eab1b54ba59e0d8b6cefcb810126c305135f30e17f02469779" => :el_capitan
    sha256 "6cb7016b3bfc792b073b2281f74e5345cd400b51a4a7d7db5b17f36e8b93ff4a" => :yosemite
  end

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
