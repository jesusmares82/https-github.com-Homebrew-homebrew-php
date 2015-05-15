require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "d806f0c150ca75209c0dcf94eb980094349fe65bae5b166ad0d36b10e0372058" => :yosemite
    sha256 "be60d95e31ffff141b593b7b8f13d1e3e6254909751f3778373fdc4e077b2a33" => :mavericks
    sha256 "f343e94c96d4a1cf41d3b0847a33ae967c42dd7d037b0b7bfa39f8e1f6f029bd" => :mountain_lion
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
