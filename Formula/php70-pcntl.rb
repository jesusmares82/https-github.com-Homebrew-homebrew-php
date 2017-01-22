require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "4fe86b4744a7917d7f9136962d6907bcc9251c5359ee9811ebe7a8ddc3107a4e" => :sierra
    sha256 "e32af2db9d6bfc96264cedc8ca3a9b0b83a34627ee224f46e2f7924c84b1672d" => :el_capitan
    sha256 "0d645181ebca73f3f18bc531b3692300a65408f22adf80c809c64942b8ea9cdd" => :yosemite
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
