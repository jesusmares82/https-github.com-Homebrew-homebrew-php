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
    revision 5
    sha256 "7b442862dd0d49d4b32d842e7678af6d2d9a0d8cb9c34b77d4ce6c5aa45eb206" => :el_capitan
    sha256 "1888e1b95d80a7626f91cbddcb5277b1f4de06a046d4e6f78308439b4c13db10" => :yosemite
    sha256 "699ef807c847d2b6a36e2602b66dee08a6fdbec622cc2b5e00ee7d579be3a2a7" => :mavericks
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


