require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "https://php.net/manual/en/book.mcrypt.php"
  revision 16

  bottle do
    sha256 "e6654718c3af488644b053a47da09e8fd3456fdd54cb43456618abd3de0b8d97" => :high_sierra
    sha256 "4ab7cb4a260eec31a5f2ae7c2b1de4f98434f155f1c5d07a35a7eb37944134fd" => :sierra
    sha256 "d042c4e7130b5e05dac3307b2e982dfeb70294c3e9284048e19488d1670c17fe" => :el_capitan
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
