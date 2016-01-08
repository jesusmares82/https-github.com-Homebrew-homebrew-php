require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 6
    sha256 "186ee9240c2862dce8940f9fb8acadb62d78f2b02fd267bdaac15435aa6f9646" => :el_capitan
    sha256 "5f905c5f695022373b9136f332a432ab3922ef25c01c026b45072c2d2c179c05" => :yosemite
    sha256 "25a181d26371c90aaf5609be405fbddcdb249192f0c1dffd4eea69b7f350ea7d" => :mavericks
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

