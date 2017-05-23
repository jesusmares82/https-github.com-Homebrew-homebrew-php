require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 11

  bottle do
    sha256 "6d762de6ac6f129857cc0f57cc37d3a543aa6ae404df2bda2acd63585a039128" => :sierra
    sha256 "fcee05b4f18b5157cfe5551823cbd32d852364e15e837ff4f2d4725c72ca0711" => :el_capitan
    sha256 "578eb8b792b03dea19096737c91f363a5267aeffe97a391e23467676ca660d3c" => :yosemite
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
