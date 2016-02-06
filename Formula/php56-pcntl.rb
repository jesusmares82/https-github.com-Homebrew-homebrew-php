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
    revision 7
    sha256 "0689d8dcd8e39de83a2f852235857fdcdfc5115901401a2e85a8e5d367eaf50e" => :el_capitan
    sha256 "fdc54b0616b5568a479c74e49254d4b99f9f28b1aa0b4598bceab1391aa44d39" => :yosemite
    sha256 "adea42a0d0392e16fe0b36c6b9f5001ff28e884fce4f86f4040e28a32c34732b" => :mavericks
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


