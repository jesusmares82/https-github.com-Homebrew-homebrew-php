require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 6

  bottle do
    rebuild 1
    sha256 "ef93951379265f385b83c0a8d75318a2504a28d66a71b008f419cb3405ef593d" => :sierra
    sha256 "cc15ff91d8054ec35185cfd8d73198d9bb3dac5d5d6fba3606ce7f2709095735" => :el_capitan
    sha256 "d67bf7def6428c848864660515267e8d691204f6667b3643a32d73d06bafe7d7" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

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
