require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "769daebb729499addd187b79fffb786215340fae10c56156944bde6f19025528" => :sierra
    sha256 "5b5cd8552faa9dd0b484f954b9b599f5919d481bdf20adae9df7d6490f9c81bc" => :el_capitan
    sha256 "3571040f8468f7583ad4ceb7a651ac2122fb2370d6e264112eb38750d711302e" => :yosemite
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
