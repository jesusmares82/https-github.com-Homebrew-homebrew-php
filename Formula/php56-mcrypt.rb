require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "df3d050932a27c1a8a189a6d5cdfab7bb64a8313f33e6526aacefb84f58f7648" => :el_capitan
    sha256 "19f12a83ebc4a3e774c032fc434b9f96f9714bb50ae2fb8cf173fa5387745bbd" => :yosemite
    sha256 "8a5b196fec8ffb1a70cf9638ad3e08e733f29add71bbc7c5d5590e661dc50040" => :mavericks
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
