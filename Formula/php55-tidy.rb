require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "a1c4e3bd8357f593303ae02fc2aecb2a838b89c02820c7f2f817ca809e7588a1" => :yosemite
    sha256 "b3c5d467906f2f1ae1c1229006c44fdfc55b887af166def1126e5de8de3f852b" => :mavericks
    sha256 "02f6cb93e98b2163700f0152125b90a3f5c36141c73ae2072dc4d0c37c3dd593" => :mountain_lion
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
