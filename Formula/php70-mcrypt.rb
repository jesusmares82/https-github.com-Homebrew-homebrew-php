require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 12

  bottle do
    sha256 "c36ea9de078803902239be56e54d8567512d666e502896bc1a53df1adbe95461" => :sierra
    sha256 "bc13b2eb76a5bc9ba27066e0758a33dba156d07d5ae933590467758211c31df3" => :el_capitan
    sha256 "c2254e729eb2cfa154a1678dbf2ce07930c0ec7439abc1d08851135524b104fb" => :yosemite
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
