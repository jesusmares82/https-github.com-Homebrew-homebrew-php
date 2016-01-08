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
    revision 4
    sha256 "8e288d405929874576c4ab5fc3fbbbe046f2ceafc2bf7fef5dd4d899b34721c7" => :el_capitan
    sha256 "7bc14c50d8fc340a5f139ffdebe8fc5b5373d3e290eba3ec0e05fa86ac4e7f8a" => :yosemite
    sha256 "728b6db4ac6fedc2df3b58eb2b92d368fd8ae4e4c934831b0e48289c682c5339" => :mavericks
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

