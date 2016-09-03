require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "ecc0c02a1668af247ffe81c86d30542cda40ca3f448c449afb471d739a27c771" => :el_capitan
    sha256 "5a60d04a483824d79d74b497dc3d24839d141c6f1084e65a0f794e9abbe1e8d3" => :yosemite
    sha256 "3b5bcadff8cb4da68b7cda23c0be8ab0599d338deca38d212dcb5b211b0ac2e9" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
