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
    revision 3
    sha256 "a981fb91a75efcbf7db9e1c70c78125831e785715c613ab45c473f043b209aee" => :el_capitan
    sha256 "ed5465e21a7b8dca50c90d37253ab3760a0b6730edab0f07c0ae5ff367b3e787" => :yosemite
    sha256 "a9fb984012991476cf647858fab678975990bc456e6650161cd525d008160c79" => :mavericks
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
