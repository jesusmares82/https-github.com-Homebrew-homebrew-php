require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "13d7a16bba6083d0e69a2e7456d9cb90e44bb06bfa3a482f67e69089cb85c93a" => :sierra
    sha256 "4da04cf57e0450b6f02f163324d9186a17350e12b0bd1ba6c84a953c23eee623" => :el_capitan
    sha256 "0ac2e2e85985650fec300db2b6936753e7e0b7d4b5a6c4f9eaa6d797dcc44242" => :yosemite
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
