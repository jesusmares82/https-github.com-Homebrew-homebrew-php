require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 6
    sha256 "84ad4922d98a150a7d00c6a0a05ff5ca257a7fa83c2690e6aec146d256f5112e" => :el_capitan
    sha256 "bd90ce7af1810c5abfc1331cfa2ed59cd5133f77286b2a6fb8215d27f7409dee" => :yosemite
    sha256 "a92934b4c027bf4625d0dcc3a92ba1ea1cac01e474c1b96ccf72c98e1034c131" => :mavericks
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



