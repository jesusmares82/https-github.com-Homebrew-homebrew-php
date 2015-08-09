require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tidy < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "8a206eb3b0dfb54d83e7db6e379c59638cafc4ac7e137e86ed5fed448822831d" => :yosemite
    sha256 "8e818066467c5c6c0e4209df9058181d957699911f269c7d0fa48a9bea3dd580" => :mavericks
    sha256 "3b0f92480a77fd3c0604ecdee61bb2df2639bbb034176561aeb30b459d9628f9" => :mountain_lion
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

