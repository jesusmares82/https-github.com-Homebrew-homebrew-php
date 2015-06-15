require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "4e6a5c1d56ff3c7c57bc080404022695fcca155a60ebc2b84435670988be6deb" => :yosemite
    sha256 "03b33a9ffcc7c7b558ddced60248709913e7e4f29b8a96256da135fb9cc4e056" => :mavericks
    sha256 "a3d35b0451d59239aafcdd3b4b024079122ec1df693c7d0423f40676c0919dd6" => :mountain_lion
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
end
