require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "e9382ae08490a727d411fa4aace7cd1e1f5b9dc7f160602bc5577922dd08ba33" => :yosemite
    sha256 "8f9ecd77f3108e900aaf6a6d1bfbbce61ae8bd16bb06f9ca53916e5c6a28e4e5" => :mavericks
    sha256 "8448559d1901574d3af120c5f29e119727a5bc05cbd918760941d597cd7a5377" => :mountain_lion
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

