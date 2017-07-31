require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 12

  bottle do
    cellar :any_skip_relocation
    sha256 "4b6cf4b43a2843b1a3623a6a49324384482ea3cc06d767c0eb1a234e06332954" => :sierra
    sha256 "0e9695db886696affde3c1bec167585857699e123978dee9bafb94cb800755fe" => :el_capitan
    sha256 "07f9fee21aacd84a97682d261bb121e888472f995245932e8b077c8e57e456f1" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
