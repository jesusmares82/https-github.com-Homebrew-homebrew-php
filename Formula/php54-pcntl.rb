require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pcntl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "0c9628a1d2eea562333d41a95c12c88d328534ca01d593042f05840563977712" => :yosemite
    sha256 "9a4910a55ab2924d2f72cc2e6235cde5bfc379c8cd156ca5aa6b88a4cecfc15b" => :mavericks
    sha256 "2527dcce2366da03c7c7ac8edd4d7450432fe87a2c9c874a0d4f47ed83380d5b" => :mountain_lion
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
