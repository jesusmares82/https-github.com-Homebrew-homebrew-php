require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 5

  bottle do
    cellar :any_skip_relocation
    sha256 "0a5077def98fc198d083d07511e7ee5250a63e279c83d1360fcb90b3aa84bdca" => :high_sierra
    sha256 "544762a52115643dcdce73bfe025041fb70b674cb6df1923d114da3238eb03b8" => :sierra
    sha256 "ee4c99084b8590d21e7c9ca9ee023248ea0ef403fefd65bea2fb02dc50d5db8a" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
