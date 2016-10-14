require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "ca36eefba0dd032489ab105f2dfa58027a2fdd2bce661ce2bc11b3c021e1825f" => :sierra
    sha256 "2539a1e461b765f38b56531960379b8b38b5624fc2d595f2041bdc98b59182b3" => :el_capitan
    sha256 "e7af3a2a79b8331efd226517dba46d6fdfc50071c39c93dbe83c9cac34a37507" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

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
