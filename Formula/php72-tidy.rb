require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"

  bottle do
    sha256 "b6ad159b66270b3a39fe5669fdabd9e2b93a726f3680c39dabfa46ecce28748d" => :sierra
    sha256 "03e842831ff8e908db8d0e7309dc218bdb367c4702b0c8912b50e7a042fe909f" => :el_capitan
    sha256 "cc1a509b94bba19a19675a43912461ebc106540b4460302ebc98a71e99d23575" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
