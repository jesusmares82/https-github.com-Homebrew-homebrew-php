require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "b3ceab47f323709c085e7453e5a61327521c7b1fbe868b5a58f332bde06c0364" => :yosemite
    sha256 "18b680279e6e7146fce9f6225445d34bb9794c458bbbdf62fea3a32e061d4b92" => :mavericks
    sha256 "12ba4db5cb4f189ced5590362300b57b10b804a61121d42e6a3a74810491f8e3" => :mountain_lion
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

