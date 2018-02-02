require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 20

  bottle do
    sha256 "ef372638826dda2219f0ade61007fcd119f66ee1affbef018b02d58b9590e21d" => :high_sierra
    sha256 "7cc7c860001a5d599031f0ec7d1179e84439d140d05ff533901d475f02432806" => :sierra
    sha256 "437fa7497ac26229f03a41e1b2148e1fd7695dbf24a988ed66893552d1625586" => :el_capitan
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
