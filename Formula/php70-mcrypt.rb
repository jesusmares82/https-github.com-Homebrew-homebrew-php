require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 16

  bottle do
    sha256 "bc58b1d58fdc71ab7e9f187d6ca2653d961e7baf50766a0cd6fbdd47c0892081" => :high_sierra
    sha256 "e1170b4b6d702deca6704d435ba0cbd3a92d599c3c745b14e859ce4e89a152ca" => :sierra
    sha256 "0f017a1aa6cc12c277eb360ca0b32149ba1f8d2ed1b386f94a95f29a2ae94c8f" => :el_capitan
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
