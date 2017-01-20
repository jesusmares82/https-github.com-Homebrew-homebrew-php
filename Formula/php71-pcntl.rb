require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 8

  bottle do
    cellar :any_skip_relocation
    sha256 "1b347575de7a553a50e203d4d51e31aadbc8abf514a87283c620ac7bf2f19103" => :sierra
    sha256 "8201abf77dd3fab52acc16c0c6e3cc2a02a1969bfdb926193a578d882a7d9404" => :el_capitan
    sha256 "cfe7cf1941cdb686cd728136558931c855de67477a3d0dfdbbb6c4078cba599a" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
