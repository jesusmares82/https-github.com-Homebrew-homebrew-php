require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 13
    sha256 "6a41486ed3aedb622ccc4df5bd3afb0abbe8295b0bcfa4df7802fc5cf518aa4c" => :el_capitan
    sha256 "dd8c8c003d2b211cf376d75d8aa44089aa4d010e3ea7bd99b6257c85c2cb2a9b" => :yosemite
    sha256 "492212e01b09ce5dcdca0f475d305632311865d3d34b51b08f74fcd7b255db92" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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






