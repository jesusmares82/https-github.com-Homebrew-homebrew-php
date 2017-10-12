require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 7

  bottle do
    cellar :any_skip_relocation
    sha256 "035766ac7e441e2859e562bdaa330f16a698e9ac9ff1f7ed17d2df0061caad88" => :high_sierra
    sha256 "1e01069e918f0d62090c7461e909d3cdf9d0e8e6039e8e26004ceb47ffbba97d" => :sierra
    sha256 "9559c9df2543c62e2257b8f6cd20b7534b3d8f7127c81f844cbdb5bb08a069fd" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
