require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    cellar :any_skip_relocation
    rebuild 13
    sha256 "ccb9c25ad6dc8b16ffbaab8f3fad393b65deae9b40965bc3a01e4b9150723027" => :el_capitan
    sha256 "767427b4d1747d4bd36a00f04f3f389c5894b5c7101b68494a28975b6d363546" => :yosemite
    sha256 "f7b29676d2cfb896ffc744d880c064415fbb70cff7f28b94aeb16c2c4e4d2f40" => :mavericks
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
