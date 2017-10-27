require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision 5

  bottle do
    cellar :any_skip_relocation
    sha256 "d6822fbfc32092b572a44871a44467bd08d984f119d1091a76141718b8ac13fd" => :high_sierra
    sha256 "37d3dcb20c99e35f51b55c105787d7dbe35bd3a7002239e8053ce90b02edd282" => :sierra
    sha256 "020c06d7203e869f1ca4fc65ea8facf26ae39324ffcef07c4870767c05dc9f01" => :el_capitan
  end

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
