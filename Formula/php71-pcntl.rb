require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "bab38c0983ca3927131589fe26fd1384e29ada9061fdcfd90fdc6e907aba0ae3" => :sierra
    sha256 "f03502f862aeb30d4b6ee97a7dea3c252b7d2963da6a621467b0bbd45cd4a0b1" => :el_capitan
    sha256 "721bd79ee25f50f0f2b1991d11f52d2dc194b75701b92fc949e42252908f9800" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

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
