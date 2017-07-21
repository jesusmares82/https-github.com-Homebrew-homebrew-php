require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 14

  bottle do
    cellar :any_skip_relocation
    sha256 "ddc5fde95b63df9a186c156e62af71df7cc57f22b5ef15cd9395cc75b8834363" => :sierra
    sha256 "6f136a945d0946008fd8e99ae9094d2730b2e9abb34f051d23742b2fdf6017b1" => :el_capitan
    sha256 "eac9730c7f9516f68b0bbba4cbe0cdfd6a40031e67771197afaf668db9ea2cf6" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
