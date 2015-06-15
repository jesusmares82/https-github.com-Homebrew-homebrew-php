require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tidy < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "c9a0c045b80afb2f1ed3fdf7e6c78aeb17d8e587fc0319ea332179c113bffe10" => :yosemite
    sha256 "9a078fff883d0398cffeca8d364a13f08984dd4e598ce89c5f17f2bb31a5efff" => :mavericks
    sha256 "0011c27be85044a8e66ef1eb11161e93bc7b3230d1ccdf9ce1f09c156265cb56" => :mountain_lion
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
