require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 11
    sha256 "2d819245053591acd32fc24a46769d6c2c3c72edaea84cb095518cc4c58d0dac" => :el_capitan
    sha256 "74a2a6351d7d9ba3ee05417327c12b553b14207bd6145fe555814e86fe4518ff" => :yosemite
    sha256 "2193892ad4da38489ae480a9f13e3cbfb7a1e813f905e8bf512d43c8da217ff3" => :mavericks
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



