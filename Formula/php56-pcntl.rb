require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 12
    sha256 "ae270d39c4b87b21823fd64850ec603a57d54647cee7c199e752ecc6f64d4ebc" => :el_capitan
    sha256 "d4a84e6b19005a98e9885591ae562df23d6184617650a5a9a3a0a4462cc43c86" => :yosemite
    sha256 "cfbb20dceedf460cec8be2621334d1c7bc762d78277f0d6c35e7480e8030dc32" => :mavericks
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








