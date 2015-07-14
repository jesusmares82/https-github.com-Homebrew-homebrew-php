require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "6b6c80c3f9f0442549e05fbe561c212d94c425a0d59b6abfe046d84ca9b77c26" => :yosemite
    sha256 "9f68be2cc49342c5b8cfc2e7c563d78a593809af8ca73c0e5f951f6475c6748f" => :mavericks
    sha256 "418bf4f5820c10f4b7157e9fa39c7a43da3f951a3ecfdace00fbe898cb25beb8" => :mountain_lion
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

