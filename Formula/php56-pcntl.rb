require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  bottle do
    cellar :any_skip_relocation
    sha256 "486f2657a3ac30077481a74f2d239ab40ecafe9a1f3091639e6ffeac43ba2c0e" => :sierra
    sha256 "da80d52621305704676b5aa3d10200e295c2632d7bf6c6d3d8bc11c66d0a39ca" => :el_capitan
    sha256 "07b8ca1cf310d72c3cc5af111e9036e851b00a1ffb963c6ab1d1dfe2a3cbddc5" => :yosemite
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
