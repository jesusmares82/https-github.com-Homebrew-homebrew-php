require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 10

  bottle do
    cellar :any_skip_relocation
    sha256 "ff5215eed9d8165965ebdaf16d1ef2e6b877894433849f28280a463e64479a49" => :sierra
    sha256 "14248c5ce15106ae132a8c52db58aeed4fafdd8eff471e45911da040f59817b3" => :el_capitan
    sha256 "1d21a18f97d3342bc1265c0bcbf49ccbe104922e7d69a05ca14339295538d6ee" => :yosemite
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
