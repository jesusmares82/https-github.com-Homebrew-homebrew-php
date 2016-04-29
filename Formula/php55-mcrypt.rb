require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "a9bb39086d99ff5bb6ca8ea29661317e310c1cabe3c0f9b42ddc309157070c30" => :el_capitan
    sha256 "d37302e177359102656752be556878e27fab1b61026a44fc7d2b5d9c6d698db2" => :yosemite
    sha256 "54a68478d02fcdef31ed63b03da7b8186ff60c0e462fef92de9376c9c52af092" => :mavericks
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





