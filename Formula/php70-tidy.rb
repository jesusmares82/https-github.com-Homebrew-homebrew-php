require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "3bfa9f3e6cf1b50bbde7eea47c2deeb97b550bd159029ffb7f5baf569c95d179" => :yosemite
    sha256 "da246315a867db62ecb89968d23feb8d31ccbb77731c925bde6b6a37f9b50c30" => :mavericks
    sha256 "d08c427ad9b4b5c81a1e0f063069ee7bb9456190fb0524f5449964f6ba426b9e" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("tidy")
  end
end
