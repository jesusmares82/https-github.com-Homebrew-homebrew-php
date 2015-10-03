require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 2
    sha256 "fea14bf3da4c799cbd3fd063349bdb6ccbff99ca4962e4a5de7340062872d66e" => :el_capitan
    sha256 "d61c97bd9c1e4c64e0152770c8200975f924f1cc6a52054f48562df8ab34b86e" => :yosemite
    sha256 "80d47505f1ba186a8a49204d7ada4c193f1f63844623d76ebde0e8c76e2eea38" => :mavericks
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
