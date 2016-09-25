require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "b19d6033e64fc0b140ae6ff93e09f4ad8714f892abc6931b6efbbb42a7780596" => :sierra
    sha256 "83d6248e5ddb6a4df72bd8d384a5a73c17ad3e4966a13bb238a74c5d722aa057" => :el_capitan
    sha256 "87e910f061facfd1eea7c11da832727f96ecccde7c2ef958b42e3e19a6509b95" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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
