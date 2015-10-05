require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 3
    sha256 "ed4affbc8d42a6d9b25cfa5f299c0020562b8ed25053754f12593af7cebc65ec" => :el_capitan
    sha256 "1f5a89eb54b4eb83a5b0c7dd64ec4f765e23dd20d5e3f4cdf9bafacb77444b31" => :yosemite
    sha256 "2e3295252f11d6ccae547dfba2150026ceaa4af8e7b32cb73565baba5fc69163" => :mavericks
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
