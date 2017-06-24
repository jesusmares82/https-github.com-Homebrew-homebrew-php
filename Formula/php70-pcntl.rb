require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 11

  bottle do
    cellar :any_skip_relocation
    sha256 "4b8caa4e1bb16501a31e028a9df6f312ea8677acadb814face82454633de9a11" => :sierra
    sha256 "19848604dbca7076f3bc1827a3f5b7f7ec4068893fb7aa31f47825efc5513b58" => :el_capitan
    sha256 "f97b0f447dcd1287a7e8a1b20800cd7f33ea685b7bb85c124c80f93333c99c11" => :yosemite
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
