require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pcntl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "386dd6e9dedcc7948eb9c25e85592d90cd574956d71d64d93d1761f9a41b034c" => :yosemite
    sha256 "43bb8a87c995970fd26ec0902fa4676a09c1ac68f70d721ea7dcd7970c567584" => :mavericks
    sha256 "d659f0ee936024320f11d0e8672497c546a502ea4d559b7a29fccb5349bf2d89" => :mountain_lion
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
