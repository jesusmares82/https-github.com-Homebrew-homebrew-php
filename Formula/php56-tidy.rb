require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "6cc8bf593f24b24fb3057fef2fc03f6444a6d187455617ff685b2feac2a8ee8d" => :yosemite
    sha256 "5f580bac96dbf97b1114fcb980682ce50f9f0900979483000d388374e0a9611d" => :mavericks
    sha256 "92458e056fae25914aad4cb9f51250f68cf14abd63efc20d7e28fbc6fc9a9bc5" => :mountain_lion
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


