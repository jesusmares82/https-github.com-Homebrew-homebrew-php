require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 15

  bottle do
    cellar :any_skip_relocation
    sha256 "2e81c9b3a0bf2ef3b2b24816adfe864a8b7b428479b7549f939ba7c8a1315d20" => :sierra
    sha256 "d82dcf7e6b8e80b8a0fb59ab62a6d5289e0de794a2d547cba4dff1cdd6f2d3df" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
