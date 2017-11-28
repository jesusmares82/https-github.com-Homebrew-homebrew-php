require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 18

  bottle do
    sha256 "4b93423ab526b51fd3a1e902af3c266b047dc9790b1905aad864ede835be5332" => :high_sierra
    sha256 "ca7a59bff2b3a87f606d589705c5d13914e964e3957922aea04645d60a00d996" => :sierra
    sha256 "4ceb4fc60a9819dc9e5bbd3fa0172ea55a983f07a3dc4514550c370b76fd3c02" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
