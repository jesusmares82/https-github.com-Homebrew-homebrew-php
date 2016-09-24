require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "36e3677c89638161b434e909b1ca7aba51cb6e410c4bb869e4f168916e713cf4" => :el_capitan
    sha256 "3788a472631f5218c945cd797448b799df547dc2e8ae2e35baf832b3fec0567f" => :yosemite
    sha256 "24618411c45dc8e53eae508ec22903e1c4b07b17e34b7cd64090225c8d41fe49" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  depends_on "mcrypt"
  depends_on "libtool" => :build

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
