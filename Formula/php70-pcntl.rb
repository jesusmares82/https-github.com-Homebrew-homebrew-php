require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "2b4c9f21f45a33ba48fb72280deb4877c24070127562dc044964acf6c29edb10" => :high_sierra
    sha256 "ed9993cc9b6848b150f13920fa706b30bb316b0607a4a4db0568c66717c11ad8" => :sierra
    sha256 "019a773ef0cc3286e7058654e36f3a4b2bfef41da1f0eb4b49b1698d2f22ef88" => :el_capitan
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
